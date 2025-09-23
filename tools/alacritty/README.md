# Alacritty Terminal

A fast, cross-platform, OpenGL terminal emulator.

## Features

- **Theme**: Doom One color scheme
- **Font**: Source Code Pro
- **Transparency**: 95% opacity
- **Key bindings**: macOS-friendly shortcuts
- **Performance**: GPU-accelerated rendering

## Installation

```bash
./install.sh
```

This will:
1. Install Alacritty via Homebrew
2. Install Source Code Pro font
3. Create config directory at `~/.config/alacritty`

## Configuration

The `alacritty.toml` file will be symlinked to `~/.config/alacritty/alacritty.toml`

### Key Bindings

- `Cmd+V` - Paste
- `Cmd+C` - Copy
- `Cmd+N` - New window
- `Cmd+Q` - Quit
- `Cmd+Plus` - Increase font size
- `Cmd+Minus` - Decrease font size
- `Cmd+0` - Reset font size
- `Cmd+K` - Clear screen
- `Cmd+Ctrl+F` - Toggle fullscreen

## Customization

Edit `alacritty.toml` to customize:
- Colors (currently using Doom One theme)
- Font size and family
- Window dimensions and padding
- Key bindings
- Shell program and arguments
