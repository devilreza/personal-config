# 🚀 Neovim Cheat Sheet
**Personal Configuration - VSCode-like Experience**

---

## 📁 FILE MANAGEMENT

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+P` | Find Files | Open file picker (like VSCode) |
| `Ctrl+Shift+P` | Command Palette | Show all available commands |
| `Ctrl+B` | Toggle File Explorer | Show/hide nvim-tree sidebar |
| `Space+e` | Focus File Explorer | Jump to file explorer |

### File Explorer (nvim-tree) Commands
When file explorer is focused:
- `a` - Create new file/folder (add `/` for folder)
- `d` - Delete file/folder
- `r` - Rename file/folder
- `x` - Cut file/folder
- `c` - Copy file/folder
- `p` - Paste file/folder
- `o` / `Enter` - Open file
- `R` - Refresh tree

---

## 💾 SAVE & QUIT

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+S` | Save File | Save current file |
| `Ctrl+Q` | Quit | Close nvim |
| `Ctrl+W` | Close Buffer | Close current file tab |

---

## 🔍 SEARCH & NAVIGATION

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+F` | Search in File | Start search in current file |
| `Ctrl+Shift+F` | Search in Project | Search across all files |
| `n` | Next Search | Go to next search result |
| `N` | Previous Search | Go to previous search result |
| `Escape` | Clear Highlight | Remove search highlighting |

---

## 🐛 ERROR & DIAGNOSTICS

| Key | Action | Description |
|-----|--------|-------------|
| `]d` | Next Error | Jump to next diagnostic/error |
| `[d` | Previous Error | Jump to previous diagnostic/error |
| `Ctrl+Shift+M` | Show All Errors | Open diagnostics list |
| `K` | Show Documentation | Hover information |
| `Space+e` | Show Error Details | Float error message |

---

## 🧭 CODE NAVIGATION

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to definition |
| `gr` | Find References | Show all references |
| `Ctrl+Shift+O` | Symbol in File | List symbols in current file |
| `Ctrl+T` | Symbol in Workspace | Find symbols across project |

---

## ✏️ EDITING

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+/` | Toggle Comment | Comment/uncomment lines |
| `Ctrl+D` | Select Word | Select word under cursor |
| `Alt+Up` | Move Line Up | Move current line up |
| `Alt+Down` | Move Line Down | Move current line down |
| `Shift+Alt+Up` | Duplicate Line Up | Copy line above |
| `Shift+Alt+Down` | Duplicate Line Down | Copy line below |
| `Ctrl+Shift+K` | Delete Line | Remove current line |
| `Shift+Alt+F` | Format Document | Auto-format code |

---

## 🔧 GO DEVELOPMENT

| Key | Action | Description |
|-----|--------|-------------|
| `Space+gr` | Run Go Program | Execute current Go file |
| `Space+gb` | Build Go Program | Build Go project |
| `Space+gt` | Run Tests | Execute Go tests |
| `Space+rn` | Rename Symbol | Rename variable/function |

---

## 🖥️ TERMINAL

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+\` | Toggle Terminal | Main floating terminal |
| `Ctrl+\`` | Alt Terminal Toggle | Alternative terminal toggle |
| `Space+th` | Horizontal Terminal | Bottom split terminal |
| `Space+tv` | Vertical Terminal | Side split terminal |
| `Space+gg` | Lazygit | Git interface terminal |
| `Space+tn` | Node Terminal | Node.js REPL |
| `Space+tp` | Python Terminal | Python REPL |

### Terminal Navigation
- `Ctrl+H/J/K/L` - Navigate between windows from terminal
- `Ctrl+\` - Exit terminal mode

---

## 🪟 WINDOW MANAGEMENT

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+H` | Left Window | Move to left split |
| `Ctrl+J` | Down Window | Move to bottom split |
| `Ctrl+K` | Up Window | Move to top split |
| `Ctrl+L` | Right Window | Move to right split |

---

## ⚡ QUICK SHORTCUTS

| Key | Action | Description |
|-----|--------|-------------|
| `jj` | Exit Insert | Quick escape from insert mode |
| `<` (visual) | Indent Left | Decrease indentation |
| `>` (visual) | Indent Right | Increase indentation |

---

## 🎨 THEME & UI

- **Theme**: Catppuccin Frappe
- **Auto Save**: Enabled (saves on text change/focus loss)
- **File Icons**: Enabled with devicons
- **Status Line**: Shows mode, git, file info, diagnostics

---

## 📋 VIM MODES REMINDER

| Mode | Description | How to Enter | How to Exit |
|------|-------------|--------------|-------------|
| **Normal** | Navigation & commands | `Esc` or `jj` | `i`, `a`, `o`, etc. |
| **Insert** | Text editing | `i`, `a`, `o`, `I`, `A`, `O` | `Esc` or `jj` |
| **Visual** | Text selection | `v`, `V`, `Ctrl+V` | `Esc` |
| **Command** | Execute commands | `:` | `Esc` or `Enter` |

---

## 🆘 USEFUL COMMANDS

| Command | Action |
|---------|--------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `:e filename` | Open/create file |
| `:ASToggle` | Toggle auto-save |
| `:Lazy` | Plugin manager |
| `:Mason` | LSP server manager |
| `:checkhealth` | Check nvim health |

---

## 💡 TIPS

1. **Leader key is `Space`** - Most custom commands start with Space
2. **Use `jj` instead of Esc** - Faster to type
3. **Ctrl+P for everything** - Quick file access
4. **Auto-save is on** - Files save automatically
5. **Terminal is floating** - Press Ctrl+\ for quick access
6. **Errors show inline** - Red squiggles like VSCode
7. **Git integration** - Use Space+gg for Lazygit

---

## 🔧 CONFIGURATION FILES

- `init.lua` - Main configuration
- `lua/plugins.lua` - Plugin setup
- `lua/keymaps.lua` - Key bindings
- `lua/config/lsp-minimal.lua` - Language server config

---

**Made with ❤️ for productive coding**