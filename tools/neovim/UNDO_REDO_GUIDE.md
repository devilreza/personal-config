# Undo/Redo Guide for Neovim

## Current Configuration

Your Neovim is now configured with enhanced undo/redo functionality:

### Key Mappings

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Ctrl+Z` | Normal, Insert, Visual | Undo | Undo last change (overrides default suspend) |
| `Ctrl+Shift+Z` | Normal, Insert, Visual | Redo | Redo last undone change |
| `Ctrl+Y` | Normal, Insert | Redo | Alternative redo mapping |
| `u` | Normal | Undo | Vim's default undo |
| `Ctrl+R` | Normal | Redo | Vim's default redo |
| `U` | Normal | Redo | Quick redo (capital U) |
| `<leader>u` | Normal | Undo Tree | Open visual undo tree |

### Features

1. **Persistent Undo History**
   - Your undo history is saved between sessions
   - Located in `~/.local/share/nvim/undo/`
   - Survives Neovim restarts

2. **Enhanced Undo Levels**
   - 10,000 undo levels (default is 1000)
   - No more losing important changes

3. **Auto-save Integration**
   - Works seamlessly with auto-save
   - No swap files needed

### Commands

- `:UndoStats` - Show undo statistics for current file
- `:UndoClear` - Clear undo history for current file
- `:UndoClearAll` - Clear all undo history
- `:earlier 5m` - Go back 5 minutes in time
- `:later 5m` - Go forward 5 minutes in time

### Restoring Default Ctrl+Z (Suspend)

If you prefer the traditional Ctrl+Z behavior (suspend Neovim):

1. Edit `~/.config/nvim/lua/keymaps.lua`
2. Comment out lines 57-59 (the Ctrl+Z mappings)
3. Uncomment line 63 to restore default behavior

### Using Undo Tree

The UndotreeToggle (`<leader>u`) provides a visual representation of your undo history:
- See all branches of changes
- Navigate between different undo states
- Never lose a change again

### Tips

1. **Time-based undo**: Use `:earlier 1h` to go back 1 hour
2. **Undo branches**: Vim keeps all undo branches, use undo tree to navigate
3. **Persistent undo**: Your changes are saved even after closing Neovim
4. **In Insert mode**: Ctrl+Z works without leaving insert mode