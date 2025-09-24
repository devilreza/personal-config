-- Neovim Configuration for Go Development
-- Modern, fast, and feature-rich setup

-- Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
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

-- Load configuration modules
require("lazy").setup("plugins")
require("options")
require("keymaps")
require("autocmds")

-- Load additional configurations after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- These configurations are not tied to specific plugins
    require("config.go").setup()
    require("config.grpc").setup()
    require("config.dockerfile").setup()
    require("config.spell").setup()
    require("config.file-finder").setup()
    require("config.autosave").setup()
    require("config.undo").setup()
    require("config.search").setup()
    require("config.git").setup()
  end,
})
