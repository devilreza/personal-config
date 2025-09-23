# Enhanced Vim Configuration

A comprehensive Vim setup based on Ultimate vimrc with modern enhancements for professional development.

## Features

### Core Configuration
- **Base**: Ultimate vimrc (amix/vimrc) with modern improvements
- **Performance**: Optimized settings for better responsiveness
- **Compatibility**: UTF-8 encoding and modern terminal support
- **Backup**: Automatic backup, undo, and swap file management

### Development Tools
- **File Navigation**: NERDTree, CtrlP, fzf integration
- **Code Navigation**: ctags, universal-ctags support
- **Search**: the_silver_searcher (ag), ripgrep (rg), fd
- **Git Integration**: vim-fugitive, GitGutter
- **Syntax**: Multi-language support with syntax checking

### Modern CLI Tools
- **Search**: `ag`, `rg`, `fd` for fast file searching
- **Viewing**: `bat` (better cat), `exa` (better ls)
- **Git**: `delta` for enhanced git diffs
- **Data**: `jq` (JSON), `yq` (YAML) processors
- **Navigation**: `tree`, `fzf` fuzzy finder

## Installation

```bash
./install.sh
```

This comprehensive installation will:
1. Install Vim and MacVim via Homebrew
2. Install Ultimate vimrc configuration
3. Install modern CLI tools and dependencies
4. Create necessary vim directories and configurations
5. Set up custom configuration files
6. Symlink the enhanced configuration

## Key Bindings

### Leader Key
- Default: `,` (comma)

### File Operations
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>x` - Save and quit
- `<leader>e` - Edit file
- `<leader>E` - Force edit file

### Buffer Management
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer
- `<leader>ba` - Show all buffers

### Window Navigation
- `<Ctrl-h>` - Move to window left
- `<Ctrl-j>` - Move to window below
- `<Ctrl-k>` - Move to window above
- `<Ctrl-l>` - Move to window right

### Tab Management
- `<leader>tn` - New tab
- `<leader>tc` - Close current tab
- `<leader>to` - Close other tabs
- `<leader>tm` - Move tab

### File Navigation
- `<leader>nn` - Toggle NERDTree
- `<leader>nf` - NERDTree find current file
- `<leader>j` - CtrlP file search
- `<leader>b` - CtrlP buffer search
- `<leader>m` - CtrlP MRU files

### Search & Replace
- `<leader>s` - Search and replace current word
- `<leader>S` - Search and replace with confirmation
- `<leader>h` - Clear search highlighting

### Utility Functions
- `<leader>n` - Toggle line numbers
- `<leader>rn` - Toggle relative line numbers
- `<leader>ln` - Toggle between absolute/relative numbers
- `<leader>p` - Toggle paste mode
- `<leader>ts` - Toggle tabs/spaces
- `<leader>cw` - Clean whitespace
- `<leader>cc` - Comment/uncomment line
- `<leader>gg` - Toggle GitGutter

### Quick Escape
- `jj`, `jk`, `kj` - Quick escape from insert mode

## Language-Specific Configurations

### Python
- 4-space indentation
- 88-character line limit (PEP 8)
- Color column at 88 characters

### JavaScript/TypeScript
- 2-space indentation
- 100-character line limit
- Color column at 100 characters

### Go
- Tab indentation (4 spaces)
- 120-character line limit
- Color column at 120 characters

### HTML/CSS
- 2-space indentation
- 120-character line limit
- Color column at 120 characters

### YAML
- 2-space indentation
- 120-character line limit
- Color column at 120 characters

### Markdown
- Word wrap enabled
- Spell checking enabled
- No line length limit

## Custom Functions

### ToggleLineNumbers()
Switch between absolute and relative line numbers
- Key: `<leader>ln`

### CleanWhitespace()
Remove trailing whitespace from the current file
- Key: `<leader>cw`

### ToggleTabSpaces()
Toggle between tab and space indentation
- Key: `<leader>ts`

## Plugin Configuration

### NERDTree
- Window size: 30 characters
- Show hidden files
- Ignore common build artifacts

### CtrlP
- Working path mode: 'ra'
- Custom ignore patterns for version control
- Integration with ag for faster searching

### Airline
- Powerline fonts enabled
- Tabline integration
- Custom theme: powerlineish

### Syntastic
- Auto-populate location list
- Check on file open
- Multi-language syntax checking

### GitGutter
- Real-time git diff indicators
- Custom key mappings disabled

## Customization

### Personal Configuration
Add your customizations to:
- `~/.vim_runtime/custom_configs.vim` - For additional configurations
- `~/.vim_runtime/my_configs.vim` - For personal overrides

### Example Custom Configuration
```vim
" Add to ~/.vim_runtime/custom_configs.vim
nnoremap <leader>xx :!echo "Hello from custom config!"<CR>

function! MyCustomFunction()
    echo "This is a custom function"
endfunction

autocmd BufWritePost *.py call MyCustomFunction()
```

## Performance Features

- Lazy redraw for better performance
- Optimized update timing
- Fast terminal rendering
- Efficient backup and undo systems

## Tips

1. Run `:PluginInstall` to ensure all plugins are installed
2. Use `:h <plugin-name>` to see plugin documentation
3. Check `~/.vim_runtime/vimrcs/` for Ultimate vimrc options
4. Customize `~/.vim_runtime/custom_configs.vim` for personal preferences
5. Try the new key mappings for improved workflow
6. Use `<leader>H` for quick help access
7. Enable spell checking with `:set spell` for text files
