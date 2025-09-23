# Vim Configuration

Vim setup with the Ultimate vimrc configuration for enhanced development experience.

## Features

- **Base**: Ultimate vimrc (amix/vimrc)
- **Plugins**: Extensive plugin ecosystem
- **File Navigation**: NERDTree, CtrlP
- **Code Navigation**: ctags integration
- **Search**: the_silver_searcher (ag) integration
- **Syntax**: Support for multiple languages

## Installation

```bash
./install.sh
```

This will:
1. Install Vim and MacVim via Homebrew
2. Install Ultimate vimrc configuration
3. Install dependencies (ctags, ag)
4. Create necessary vim directories
5. Symlink the configuration file

## Key Bindings

### Leader Key
- Default: `,` (comma)

### Essential Shortcuts
- `<leader>nn` - Toggle NERDTree
- `<leader>j` - CtrlP file search
- `<leader>f` - MRU (Most Recently Used) files
- `<leader>o` - Open buffers
- `<leader>g` - Ag search
- `<leader>cc` - Comment line
- `<leader>cu` - Uncomment line

### Window Management
- `<Ctrl-j>` - Move to window below
- `<Ctrl-k>` - Move to window above
- `<Ctrl-h>` - Move to window left
- `<Ctrl-l>` - Move to window right

### Tab Management
- `<leader>tn` - New tab
- `<leader>to` - Close other tabs
- `<leader>tc` - Close current tab
- `<leader>tm` - Move tab

## Customization

The `vimrc` file extends the Ultimate vimrc with:
- Custom key mappings
- Additional plugin configurations
- Personal preferences

To add more customizations, edit the `vimrc` file.

## Plugins

Key plugins included:
- **NERDTree** - File explorer
- **CtrlP** - Fuzzy file finder
- **vim-airline** - Status line
- **vim-fugitive** - Git integration
- **syntastic** - Syntax checking
- **vim-commentary** - Easy commenting
- **vim-surround** - Surround text objects

## Tips

1. Run `:PluginInstall` to ensure all plugins are installed
2. Use `:h <plugin-name>` to see plugin documentation
3. Check `~/.vim_runtime/vimrcs/` for more configuration options
