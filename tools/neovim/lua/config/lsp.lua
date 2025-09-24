-- LSP Configuration for Go Development
-- Language Server Protocol setup

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")

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
  ensure_installed = { 
    "gopls", 
    "lua_ls",
    "bufls",           -- Protocol Buffers language server
    "dockerls",        -- Dockerfile language server
    "docker_compose_language_service", -- Docker Compose language server
  },
  automatic_installation = true,
})

-- Setup completion
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
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- LSP keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format { async = true }
end, opts)

-- LSP on_attach function
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  
  -- Disable formatting for certain clients
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

-- Enable LSP servers using modern API
vim.lsp.enable({ 
  'gopls', 
  'lua_ls',
  'bufls',
  'dockerls',
  'docker_compose_language_service'
})

-- LSP attach autocommand for completion
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
