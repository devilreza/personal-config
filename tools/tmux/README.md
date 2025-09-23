# Tmux Configuration

Terminal multiplexer with custom configuration for enhanced productivity.

## Features

- **Mouse Support**: Full mouse support for pane selection and scrolling
- **Theme**: Nord color scheme
- **Status Bar**: Custom status bar with system information
- **Key Bindings**: Intuitive shortcuts for common operations
- **Plugin Manager**: TPM (Tmux Plugin Manager) integration

## Installation

```bash
./install.sh
```

This will:
1. Install tmux via Homebrew
2. Install Tmux Plugin Manager (TPM)
3. Install reattach-to-user-namespace for macOS clipboard support
4. Symlink the configuration file

## Key Bindings

### Prefix Key
- Default: `Ctrl-b`

### Pane Management
- `prefix + |` - Split window vertically
- `prefix + -` - Split window horizontally
- `prefix + arrow keys` - Navigate between panes
- `prefix + x` - Kill current pane

### Window Management
- `prefix + c` - Create new window
- `prefix + n` - Next window
- `prefix + p` - Previous window
- `prefix + w` - List windows

### Other
- `prefix + r` - Reload configuration
- `prefix + ?` - Show all key bindings
- `prefix + I` - Install plugins (TPM)

## Plugins

The configuration includes:
- `tmux-sensible` - Sensible tmux defaults
- `tmux-yank` - Copy to system clipboard
- `tmux-prefix-highlight` - Highlight when prefix is pressed

## Customization

Edit `tmux.conf` to customize:
- Key bindings
- Status bar appearance
- Color scheme
- Plugin configuration
