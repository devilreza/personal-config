-- Minimal Neovim Configuration
-- VSCode-like experience for beginners
-- Focus on essential features and error highlighting

-- =============================================================================
-- LEADER KEY SETUP (Must be set before lazy.nvim)
-- =============================================================================
vim.g.mapleader = " "         -- Space as leader key (like VSCode Ctrl+Shift+P)
vim.g.maplocalleader = "\\"   -- Backslash as local leader

-- =============================================================================
-- BASIC VIM OPTIONS (VSCode-like behavior)
-- =============================================================================

-- UI Settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = false  -- Don't show relative numbers (confusing for beginners)
vim.opt.signcolumn = "yes"      -- Always show sign column (for error icons)
vim.opt.wrap = false            -- Don't wrap lines
vim.opt.cursorline = true       -- Highlight current line
vim.opt.termguicolors = true    -- Enable 24-bit RGB colors

-- Indentation (VSCode defaults)
vim.opt.tabstop = 4             -- 4 spaces for tabs
vim.opt.shiftwidth = 4          -- 4 spaces for indentation
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.autoindent = true       -- Auto indent new lines

-- Search (VSCode-like)
vim.opt.ignorecase = true       -- Case insensitive search
vim.opt.smartcase = true        -- Case sensitive if uppercase used
vim.opt.hlsearch = true         -- Highlight search results
vim.opt.incsearch = true        -- Incremental search

-- File management
vim.opt.hidden = true           -- Allow switching buffers without saving
vim.opt.backup = false          -- Don't create backup files
vim.opt.writebackup = false     -- Don't backup before overwriting
vim.opt.swapfile = false        -- Don't create swap files
vim.opt.autoread = true         -- Auto reload files changed outside vim

-- Performance
vim.opt.updatetime = 300        -- Faster completion (4000ms default)
vim.opt.timeoutlen = 500        -- Time to wait for mapped sequence

-- Mouse support (like VSCode)
vim.opt.mouse = "a"             -- Enable mouse support

-- Clipboard (VSCode-like copy/paste)
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Font (Fira Code with ligatures)
vim.opt.guifont = "FiraCode Nerd Font:h18"

-- RTL/Persian Support
vim.opt.termbidi = true        -- Enable terminal bidirectional support if available
vim.opt.encoding = "utf-8"     -- Ensure UTF-8 encoding for Persian characters
vim.opt.rightleftcmd = "search" -- Allow search commands in RTL mode
-- Persian keymap will be loaded automatically when needed

-- Additional font settings for better rendering
if vim.g.neovide then
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_remember_window_size = true
end

-- =============================================================================
-- DISABLE NETRW (we use nvim-tree instead)
-- =============================================================================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =============================================================================
-- BOOTSTRAP LAZY.NVIM (Plugin Manager)
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- LOAD PLUGINS
-- =============================================================================
require("lazy").setup("plugins")

-- =============================================================================
-- LOAD KEYMAPS
-- =============================================================================
require("keymaps")

-- =============================================================================
-- AUTO COMMANDS (VSCode-like behavior)
-- =============================================================================

-- Highlight yanked text (visual feedback)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto format Go files on save (like VSCode)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Automatically organize imports for Go files (like VSCode)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
        end
      end
    end
  end,
})

-- Auto-close only the previous empty/unchanged buffer when opening new files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local current_buf = args.buf

    -- Get the alternate (previous) buffer
    local alt_buf = vim.fn.bufnr('#')

    -- Only process if there is a valid alternate buffer
    if alt_buf > 0 and alt_buf ~= current_buf and vim.api.nvim_buf_is_valid(alt_buf) then
      local buf_name = vim.api.nvim_buf_get_name(alt_buf)
      local buf_modified = vim.api.nvim_buf_get_option(alt_buf, "modified")
      local buf_type = vim.api.nvim_buf_get_option(alt_buf, "buftype")
      local buf_lines = vim.api.nvim_buf_get_lines(alt_buf, 0, -1, false)

      -- Check if buffer is empty (only one line with no content)
      local is_empty = #buf_lines == 1 and buf_lines[1] == ""

      -- Close previous buffer only if:
      -- 1. It's not modified
      -- 2. It's a normal file (not terminal, help, etc)
      -- 3. It's empty OR has no name
      -- 4. It's not displayed in any window
      if not buf_modified
         and buf_type == ""
         and (is_empty or buf_name == "")
         and #vim.fn.win_findbuf(alt_buf) == 0 then
        vim.api.nvim_buf_delete(alt_buf, { force = false })
      end
    end
  end,
})

-- =============================================================================
-- WELCOME MESSAGE
-- =============================================================================
print("🚀 Minimal Neovim loaded! Press <Space>? for help or Ctrl+P to find files")

-- =============================================================================
-- CONFIGURATION INFO
-- =============================================================================
-- To switch back to full configuration:
-- 1. Rename init.lua to init-minimal.lua
-- 2. Rename your old init.lua back
-- 3. Restart Neovim
--
-- Key files:
-- - init-minimal.lua      (this file)
-- - lua/plugins-minimal.lua  (essential plugins only)
-- - lua/keymaps-minimal.lua  (VSCode-like keybindings)
-- - lua/config/lsp-minimal.lua (error highlighting config)
-- =============================================================================
