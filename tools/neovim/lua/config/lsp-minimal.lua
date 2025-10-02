-- Minimal LSP Configuration
-- VSCode-like error highlighting and diagnostics

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- VSCode-like diagnostic configuration with enhanced error highlighting
vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",  -- Show source when multiple sources
    prefix = "●",        -- VSCode-like bullet point
    spacing = 4,
    format = function(diagnostic)
      -- Filter out package comment warnings
      if diagnostic.message:match("at least one file in a package should have a package comment") then
        return ""
      end
      return string.format("%s", diagnostic.message)
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "⚑",
      [vim.diagnostic.severity.HINT] = "⚡",
    },
  },
  underline = true,
  update_in_insert = false,  -- Don't update while typing
  severity_sort = true,      -- Sort by severity
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    format = function(diagnostic)
      -- Filter out package comment warnings in hover
      if diagnostic.message:match("at least one file in a package should have a package comment") then
        return ""
      end
      return diagnostic.message
    end,
  },
})

-- Enhanced diagnostic colors and signs
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#F38BA8", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#FAB387", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#89DCEB", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#A6E3A1", bold = true })

-- Sign column background for errors
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#F38BA8", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#FAB387", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#89DCEB", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#A6E3A1", bg = "NONE", bold = true })

-- Setup Mason
mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Setup Mason LSP Config
mason_lspconfig.setup({
  ensure_installed = { "gopls", "lua_ls" },
  automatic_installation = true,
})

-- Get blink.cmp capabilities
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Setup lspconfig
local lspconfig = require('lspconfig')

-- Check if staticcheck.conf exists in project root and return path
local function get_staticcheck_config_path(root_dir)
  local config_paths = {
    root_dir .. "/staticcheck.conf",
    root_dir .. "/.staticcheck.conf",
  }

  for _, path in ipairs(config_paths) do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end
  return nil
end

-- Parse staticcheck.conf file
local function parse_staticcheck_config(config_path)
  local config = {}
  local file = io.open(config_path, "r")
  if not file then
    return config
  end

  for line in file:lines() do
    -- Skip comments and empty lines
    line = line:match("^%s*(.-)%s*$")  -- trim whitespace
    if line ~= "" and not line:match("^#") then
      -- Parse key = value format
      local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
      if key and value then
        -- Remove quotes if present
        value = value:match('^"(.-)"$') or value:match("^'(.-)'$") or value

        -- Handle array values (e.g., checks = ["all", "-ST1000"])
        if value:match("^%[.*%]$") then
          local items = {}
          for item in value:gmatch('"([^"]+)"') do
            table.insert(items, item)
          end
          config[key] = items
        else
          config[key] = value
        end
      end
    end
  end
  file:close()
  return config
end

-- Configure gopls with dynamic staticcheck support
lspconfig.gopls.setup({
  capabilities = capabilities,
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern("go.mod", ".git")(fname) or vim.fn.getcwd()
  end,
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      -- Filter out ST1000 package comment warnings
      if result and result.diagnostics then
        result.diagnostics = vim.tbl_filter(function(diagnostic)
          return not (diagnostic.message and diagnostic.message:match("at least one file in a package should have a package comment"))
        end, result.diagnostics)
      end
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end,
  },
  on_attach = function(client, bufnr)
    -- Check for staticcheck.conf in the LSP root directory
    local root_dir = client.config.root_dir
    local config_path = get_staticcheck_config_path(root_dir)

    if config_path then
      -- Enable staticcheck if config exists
      client.config.settings.gopls.staticcheck = true
    else
      -- Disable staticcheck if no config
      client.config.settings.gopls.staticcheck = false
    end
  end,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
      },
      staticcheck = true,  -- Will be overridden in on_attach
      gofumpt = true,
      experimentalPostfixCompletions = true,
      ["local"] = "",
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
    }
  },
})

-- Configure lua_ls
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = {'vim'} },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    }
  }
})
