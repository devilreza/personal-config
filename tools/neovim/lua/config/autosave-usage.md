# Auto-Save Configuration Usage

## Overview
Auto-save automatically saves your files when you stop typing or leave insert mode.

## Default Behavior
- **Enabled by default**: Files are automatically saved
- **Trigger events**: 
  - `InsertLeave` - When you exit insert mode
  - `TextChanged` - When text changes in normal mode
  - `FocusLost` - When you switch away from Neovim
- **Debounce delay**: 135ms (prevents too frequent saves)
- **Excluded filetypes**: NvimTree, Telescope, lazy, mason, etc.

## Commands
- `:AutoSaveToggle` - Toggle auto-save on/off
- `:AutoSaveEnable` - Enable auto-save
- `:AutoSaveDisable` - Disable auto-save

## Keymaps
- `<leader>as` - Toggle auto-save

## Customization
Edit `~/.config/nvim/lua/config/autosave.lua` to customize:

```lua
require("config.autosave").setup({
  enabled = true,  -- Start with auto-save enabled
  debounce_delay = 135,  -- Milliseconds to wait before saving
  trigger_events = {"InsertLeave", "TextChanged"},  -- Events that trigger save
  write_all_buffers = false,  -- Save only current buffer (true = save all)
})
```

## Status Indication
When auto-save triggers, you'll see a notification:
```
AutoSave: saved at HH:MM:SS
```

## Tips
- Auto-save respects modifiable buffers only
- Works great with version control (git)
- Disable for specific projects with `:AutoSaveDisable`
- The save is silent and won't interrupt your workflow