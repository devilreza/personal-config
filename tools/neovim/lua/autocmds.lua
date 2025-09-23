-- Neovim Autocommands
-- File type specific settings and events

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General settings
augroup("General", { clear = true })

-- Go specific settings
augroup("Go", { clear = true })

autocmd("FileType", {
  group = "Go",
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.textwidth = 120
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldlevel = 99
    vim.opt_local.formatprg = "gofmt"
    vim.opt_local.makeprg = "go build -o /tmp/%:t:r %"
    vim.opt_local.errorformat = "%f:%l:%c:\\ %m"
    vim.opt_local.comments = "s1:/*,mb:*,ex:*/,://"
    vim.opt_local.commentstring = "// %s"
  end,
})

-- Auto format on save for Go
autocmd("BufWritePre", {
  group = "Go",
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Auto import on save for Go
autocmd("BufWritePre", {
  group = "Go",
  pattern = "*.go",
  callback = function()
    vim.cmd("GoImport")
  end,
})

-- General file type settings
augroup("FileTypes", { clear = true })

-- Python
autocmd("FileType", {
  group = "FileTypes",
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.textwidth = 88
  end,
})

-- JavaScript/TypeScript
autocmd("FileType", {
  group = "FileTypes",
  pattern = { "javascript", "typescript" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.textwidth = 100
  end,
})

-- HTML/CSS
autocmd("FileType", {
  group = "FileTypes",
  pattern = { "html", "css" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.textwidth = 120
  end,
})

-- YAML
autocmd("FileType", {
  group = "FileTypes",
  pattern = "yaml",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.textwidth = 120
  end,
})

-- Markdown
autocmd("FileType", {
  group = "FileTypes",
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 0
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- JSON
autocmd("FileType", {
  group = "FileTypes",
  pattern = "json",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Auto resize windows
augroup("Resize", { clear = true })

autocmd("VimResized", {
  group = "Resize",
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- Highlight on yank
augroup("Highlight", { clear = true })

autocmd("TextYankPost", {
  group = "Highlight",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto close quickfix
augroup("Quickfix", { clear = true })

autocmd("QuickFixCmdPost", {
  group = "Quickfix",
  pattern = "[^l]*",
  callback = function()
    vim.cmd("cwindow")
  end,
})

autocmd("QuickFixCmdPost", {
  group = "Quickfix",
  pattern = "l*",
  callback = function()
    vim.cmd("lwindow")
  end,
})

-- =============================================================================
-- GO-SPECIFIC AUTOCMDS
-- =============================================================================

-- Disable vim-go CursorHold autocommands that cause errors in Neovim 0.11+
autocmd("FileType", {
  group = "Go",
  pattern = "go",
  callback = function()
    -- Clear any problematic vim-go autocommands
    vim.cmd("autocmd! CursorHold <buffer>")
    vim.cmd("autocmd! CursorHoldI <buffer>")
  end,
})

-- Go-specific settings
autocmd("FileType", {
  group = "Go",
  pattern = "go",
  callback = function()
    -- Set Go-specific options
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
    vim.opt_local.textwidth = 0
    vim.opt_local.wrap = false
    
    -- Go formatting
    vim.opt_local.formatprg = "gofmt"
    vim.opt_local.makeprg = "go build -o /tmp/%:t:r %"
    vim.opt_local.errorformat = "%f:%l:%c:\\ %m"
    
    -- Comments
    vim.opt_local.comments = "s1:/*,mb:*,ex:*/,://"
    vim.opt_local.commentstring = "// %s"
    
    -- Folding
    vim.opt_local.foldmethod = "syntax"
    vim.opt_local.foldlevel = 99
  end,
})
