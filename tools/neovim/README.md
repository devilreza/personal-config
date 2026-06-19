# Neovim Configuration for Go Development

A modern, feature-rich Neovim configuration specifically optimized for Go development with VS Code-like experience.

## 🚀 Features

### Core Features
- **Modern Lua Configuration** - Fast, maintainable setup
- **Go Language Server** - Full LSP support with gopls
- **Advanced Go Tools** - Complete Go development toolkit
- **VS Code-like Interface** - Familiar shortcuts and workflow
- **File Explorer** - Nvim-tree sidebar for easy navigation
- **Fuzzy Finder** - Telescope for quick file/buffer search
- **Git Integration** - Gitsigns for diff indicators
- **Terminal Integration** - ToggleTerm for in-editor terminal

### Go Development Features
- **Auto Formatting** - goimports on save
- **Code Completion** - IntelliSense-like experience
- **Go to Definition** - Jump to function/type definitions
- **Find References** - Find all usages of symbols
- **Rename Symbol** - Refactor across files
- **Go Testing** - Run tests with rich output
- **Go Debugging** - Delve debugger integration
- **Go Coverage** - Test coverage visualization
- **Go Linting** - Static analysis and error checking

## 📦 Installation

```bash
./install.sh
```

This will install:
- Neovim and Go
- All Go development tools
- Modern CLI utilities
- Neovim configuration files (symlinked)
- Required plugins

### Configuration Management
- **Symlinked Setup**: All configuration files are symlinked to this directory
- **Easy Updates**: Changes to config files here are immediately reflected in Neovim
- **Version Control**: Keep your Neovim config in git alongside your dotfiles
- **Easy Reset**: Run the install script again to reset configuration

## 🎯 Quick Start

1. **Launch Neovim**: `nvim`
2. **Open file explorer**: `<leader>e` (Space + e)
3. **Find files**: `<leader>ff` (Space + f + f)
4. **Search in files**: `<leader>fg` (Space + f + g)
5. **Open terminal**: `<leader>tt` (Space + t + t)

## ⌨️ Key Bindings

### General Shortcuts
| Key | Action |
|-----|--------|
| `<leader>` | Space (leader key) |
| `<C-s>` | Save file |
| `<C-q>` | Quit |
| `<C-b>` | Toggle file explorer |
| `<C-p>` | Find files |
| `<A-f>` | Search in file (Alt+F) |
| `<C-S-f>` | Live grep (Search in project) |
| `<C-\>` | Toggle terminal |
| `<leader>ts`| Switch Themes (Theme Manager) |
| `<leader>mt`| Toggle Minuet AI |
| `<leader>ct`| Toggle Codeium AI |

### Go Development
| Key | Action |
|-----|--------|
| `<leader>gi` | Go import |
| `<leader>gf` | Go format |
| `<leader>gt` | Go test |
| `<leader>gT` | Go test function |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Find references |
| `<leader>gR` | Rename symbol |
| `<leader>gb` | Go build |
| `<leader>gr` | Go run |
| `<leader>gc` | Go coverage |

### LSP Features
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Hover information |
| `gi` | Go to implementation |
| `<leader>ca` | Code actions |
| `<leader>f` | Format document |
| `gr` | Find references |

## 🛠️ Go Tools Included

### Language Server
- **gopls** - Go Language Server Protocol

### Code Analysis
- **goimports** - Auto import management
- **godef** - Definition finder
- **guru** - Code analysis
- **gorename** - Refactoring tool
- **staticcheck** - Static analysis

### Testing & Debugging
- **gotests** - Test generation
- **dlv** - Delve debugger
- **air** - Live reload
- **richgo** - Colorized test output

### Code Quality
- **golangci-lint** - Linter aggregator
- **gofumpt** - Stricter gofmt
- **misspell** - Spell checker
- **gosec** - Security checker

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration
├── lua/
│   ├── options.lua          # Neovim options
│   ├── keymaps.lua          # Key bindings
│   ├── autocmds.lua         # Auto commands
│   ├── plugins.lua          # Plugin definitions
│   ├── colorschemes.lua     # Theme settings
│   └── config/
│       ├── go.lua           # Go-specific settings
│       ├── lsp.lua          # LSP configuration
│       ├── treesitter.lua   # Syntax highlighting
│       ├── telescope.lua    # Fuzzy finder
│       ├── nvim-tree.lua    # File explorer
│       ├── lualine.lua      # Status line
│       ├── gitsigns.lua     # Git integration
│       ├── comment.lua      # Comment toggling
│       └── toggleterm.lua   # Terminal integration
```

## 🎨 Themes

- **Catppuccin** (default) - Modern, pastel theme
- **Tokyo Night** - Dark theme with vibrant colors

Switch themes with `:colorscheme <name>`

## 🔧 Customization

### Adding New Key Bindings
Edit `lua/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>xx", ":echo 'Hello!'<CR>", opts)
```

### Adding New Plugins
Edit `lua/plugins.lua`:

```lua
{
  "plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Go-specific Settings
Edit `lua/config/go.lua` for Go plugin settings.

## 🐛 Troubleshooting

### Plugin Issues
```bash
# Update plugins
:Lazy sync

# Clean plugins
:Lazy clean
```

### Go Tools Issues
```bash
# Install Go tools
:GoInstallBinaries

# Update Go tools
:GoUpdateBinaries
```

### LSP Issues
```bash
# Restart LSP
:LspRestart

# Check LSP status
:LspInfo
```

## 📚 Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Go Plugin Documentation](https://github.com/fatih/vim-go)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim)

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This configuration is open source and available under the MIT License.
