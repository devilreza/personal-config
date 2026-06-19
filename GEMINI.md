# Project Guidelines: Neovim Configuration

This project maintains a Neovim configuration optimized for Go development with a "VS Code-like" experience for beginners.

## 🛠️ Configuration Standards

- **Language**: All configuration is written in Lua.
- **Plugin Manager**: Uses `lazy.nvim`.
- **Completion**: Uses `blink.cmp` for fast, modern completion.
- **AI Integration**: Supports both **Codeium** and **Minuet AI**.
- **User Experience**: Priority is given to VS Code-compatible shortcuts (e.g., Ctrl+S to save, Ctrl+P to find files).

## ⌨️ Custom Shortcuts & Commands

I have implemented several custom enhancements to match the user's workflow:

### AI Management
- **Command**: `:ToggleMinuet` (with aliases `:MinuetToggle` and `:ToggelMinuet`).
- **Shortcut**: `<leader>mt` (Space + m + t) to toggle Minuet AI completion.
- **Shortcut**: `<leader>ct` (Space + c + t) to toggle Codeium completion.

### Search & Navigation
- **Shortcut**: `Option + F` (mapped as `<A-f>`) to search within the current file using Telescope.
- **Shortcut**: `Ctrl + B` to toggle the file explorer.

### Theme Management
- **Shortcut**: `<leader>ts` (Space + t + s) to open the **Theme Manager**.
- **Features**: Supports live preview of themes using `telescope-themes`.
- **Bundled Themes**: Catppuccin, Tokyo Night, Rose Pine, Kanagawa, Nightfox, Nord, Gruvbox, Everforest, and OneDark.

## 📁 Directory Structure

- `tools/neovim/lua/plugins.lua`: Plugin definitions and setup.
- `tools/neovim/lua/keymaps.lua`: All keybindings and help guides.
- `tools/neovim/lua/config/`: Detailed configuration for specific tools (LSP, etc.).
