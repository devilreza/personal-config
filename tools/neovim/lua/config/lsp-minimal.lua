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
  -- Note: rust_analyzer is intentionally NOT listed here — rustaceanvim manages
  -- it directly and picks the binary up from $PATH (installed via rustup).
  ensure_installed = {
    "gopls", "lua_ls",
    -- React / TypeScript / web stack
    "ts_ls",                  -- TypeScript / JavaScript
    "eslint",                 -- ESLint LSP (lint + fix-on-save code action)
    "tailwindcss",            -- Tailwind class IntelliSense
    "cssls",                  -- CSS / SCSS
    "html",                   -- HTML
    "emmet_language_server",  -- Emmet for HTML/JSX
    "jsonls",                 -- JSON + schema-aware
  },
  automatic_installation = true,
})

-- Get blink.cmp capabilities
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Setup lspconfig
local lspconfig = require('lspconfig')

-- Common on_attach function for LSP clients
local on_attach = function(client, bufnr)
  -- Set up LSP keybindings for this buffer
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  
  -- Navigation
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', bufopts, { desc = 'Go to definition' }))
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.declaration, vim.tbl_extend('force', bufopts, { desc = 'Go to declaration' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', bufopts, { desc = 'Go to implementation' }))
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, vim.tbl_extend('force', bufopts, { desc = 'Go to type definition' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', bufopts, { desc = 'Find references' }))
  
  -- Documentation
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', bufopts, { desc = 'Show documentation' }))
  vim.keymap.set('n', '<C-S-Space>', vim.lsp.buf.signature_help, vim.tbl_extend('force', bufopts, { desc = 'Signature help' }))
  vim.keymap.set('i', '<C-S-Space>', vim.lsp.buf.signature_help, vim.tbl_extend('force', bufopts, { desc = 'Signature help' }))
  
  -- Rename
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, vim.tbl_extend('force', bufopts, { desc = 'Rename symbol' }))
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', bufopts, { desc = 'Rename symbol' }))
  
  -- Format
  vim.keymap.set('n', '<S-A-f>', vim.lsp.buf.format, vim.tbl_extend('force', bufopts, { desc = 'Format document' }))
  
  -- Diagnostics
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', bufopts, { desc = 'Next diagnostic' }))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', bufopts, { desc = 'Previous diagnostic' }))
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, vim.tbl_extend('force', bufopts, { desc = 'Show error details' }))
end

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
-- Note: go.nvim plugin also sets up gopls, so this might be redundant
-- But we keep it for non-Go files or if go.nvim is disabled
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
      -- Use the default handler
      local default_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
      if default_handler then
        default_handler(err, result, ctx, config)
      end
    end,
  },
  on_attach = function(client, bufnr)
    -- Call the common on_attach to set up keybindings
    on_attach(client, bufnr)
    
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

-- Export on_attach for use by other plugins (like go.nvim)
_G.lsp_on_attach = on_attach

-- Configure lua_ls
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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

-- =============================================================================
-- REACT / TYPESCRIPT / WEB STACK
-- =============================================================================
-- TypeScript / JavaScript / JSX / TSX
-- Formatting is handled by conform.nvim (prettier), so we disable ts_ls's own
-- formatter to avoid double-formatting and prettier-vs-tsserver conflicts.
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "literals",
      includeInlayFunctionParameterTypeHints = false,
      includeInlayVariableTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
})

-- ESLint LSP: provides diagnostics and an "EslintFixAll" command + code action
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Run "fix all" code action on save (separate from prettier formatting)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  settings = {
    workingDirectories = { mode = "auto" },
  },
})

-- Tailwind CSS IntelliSense
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "html", "css", "scss", "sass",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "vue", "svelte", "astro",
  },
})

-- CSS / SCSS / Less
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
})

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
})

-- Emmet (HTML / JSX abbreviation expansion)
lspconfig.emmet_language_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "html", "css", "scss", "sass", "less",
    "javascriptreact", "typescriptreact",
    "vue", "svelte", "astro",
  },
})

-- JSON with schema support (package.json, tsconfig.json, etc.)
lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
  settings = {
    json = {
      validate = { enable = true },
    },
  },
})
