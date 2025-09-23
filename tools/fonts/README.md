# Terminal Fonts

Nerd Fonts and terminal-optimized fonts for proper icon and symbol display.

## Overview

This installer provides fonts with extended character sets that include:
- Powerline symbols
- Font Awesome icons
- Devicons
- Octicons
- Material Design icons
- Weather icons
- And many more...

These fonts are essential for:
- Powerlevel10k theme
- Terminal status lines
- Development tool icons
- File type icons in terminal file managers

## Installation

```bash
./install.sh
```

## Included Fonts

### MesloLGS NF
- **Recommended for**: Powerlevel10k
- **Description**: Specifically tuned for P10k with perfect symbol alignment
- **Variants**: Regular, Bold, Italic, Bold Italic

### SauceCodePro Nerd Font
- **Base**: Source Code Pro
- **Description**: Adobe's monospace font with Nerd Font patches
- **Good for**: General programming with excellent readability

### Hack Nerd Font
- **Description**: A typeface designed for source code
- **Features**: Clear distinction between similar characters

### JetBrains Mono Nerd Font
- **Description**: Font designed by JetBrains for developers
- **Features**: Ligatures, clear character distinctions

### Fira Code Nerd Font
- **Description**: Monospace font with programming ligatures
- **Features**: Arrow ligatures, operator ligatures

## Font Configuration

### Alacritty
Edit `~/.config/alacritty/alacritty.toml`:
```toml
[font]
normal = { family = "MesloLGS Nerd Font", style = "Regular" }
size = 13.0
```

### iTerm2
1. Open Preferences → Profiles → Text
2. Click "Change Font"
3. Select "MesloLGS NF Regular"
4. Enable "Use ligatures" if desired

### VS Code
Add to `settings.json`:
```json
{
  "editor.fontFamily": "'JetBrainsMono Nerd Font', Menlo, Monaco, 'Courier New', monospace",
  "editor.fontSize": 13,
  "editor.fontLigatures": true,
  "terminal.integrated.fontFamily": "'MesloLGS NF'"
}
```

### Terminal.app
1. Open Preferences → Profiles
2. Click "Change" under Font
3. Select a Nerd Font

## Verifying Installation

Run this command to see all installed Nerd Fonts:
```bash
fc-list | grep -i "nerd font" | cut -d: -f2 | sort -u
```

## Troubleshooting

### Icons not showing correctly
1. Ensure you've selected a Nerd Font in your terminal
2. Restart your terminal after font installation
3. Run `p10k configure` if using Powerlevel10k

### Font not appearing in font list
1. Check installation path: `ls ~/Library/Fonts/*Nerd*`
2. Refresh font cache: `fc-cache -f`
3. Restart applications that use fonts

### Wrong font variant loading
Some applications cache fonts. Try:
1. Quit and restart the application
2. Log out and log back in
3. In extreme cases, restart your Mac

## Additional Fonts

To install more Nerd Fonts, visit:
- [Nerd Fonts Repository](https://github.com/ryanoasis/nerd-fonts)
- [Nerd Fonts Patcher](https://github.com/ryanoasis/nerd-fonts#font-patcher)

You can patch your own favorite font with:
```bash
docker run --rm -v /path/to/font:/in -v /output:/out nerdfonts/patcher
```
