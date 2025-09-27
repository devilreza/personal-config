-- Minimal LSP Configuration
-- VSCode-like error highlighting and diagnostics

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")

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

-- Setup autocompletion
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- LSP servers configuration using modern vim.lsp.config (Neovim 0.11+)
local configs = {
  gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.work', 'go.mod', '.git' },
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
        -- Staticcheck will automatically find staticcheck.conf in project root
        -- No additional configuration needed for gopls
      }
    }
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.git' },
    settings = {
      Lua = {
        diagnostics = { globals = {'vim'} },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      }
    }
  },
}

-- Setup LSP servers
for name, config in pairs(configs) do
  vim.lsp.config[name] = config
end

-- Enable LSP servers
vim.lsp.enable({ 'gopls', 'lua_ls' })

-- LSP attach autocommand for completion
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
