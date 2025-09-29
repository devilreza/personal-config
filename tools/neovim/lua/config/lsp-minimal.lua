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

-- Configure gopls
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        ST1000 = false,  -- Disable package comment warnings
      },
      staticcheck = true,
      gofumpt = true,
      experimentalPostfixCompletions = true,
      ["local"] = "",
    }
  }
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
