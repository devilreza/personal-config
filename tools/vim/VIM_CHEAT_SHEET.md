# Vim Cheat Sheet
*Enhanced Vim Configuration Quick Reference*

## Table of Contents
- [VS Code-like Shortcuts](#vs-code-like-shortcuts)
- [Basic Navigation](#basic-navigation)
- [File Operations](#file-operations)
- [Buffer Management](#buffer-management)
- [Window Management](#window-management)
- [Tab Management](#tab-management)
- [Search & Replace](#search--replace)
- [Text Editing](#text-editing)
- [Visual Mode](#visual-mode)
- [Insert Mode](#insert-mode)
- [Command Mode](#command-mode)
- [Plugin Shortcuts](#plugin-shortcuts)
- [Custom Functions](#custom-functions)
- [Language-Specific](#language-specific)
- [Utility Commands](#utility-commands)

---

## VS Code-like Shortcuts

| Key | Action | VS Code Equivalent |
|-----|--------|-------------------|
| `Ctrl-s` | Save file | `Ctrl-s` |
| `Ctrl-w` | Close current file | `Ctrl-w` |
| `Ctrl-q` | Quit all | `Ctrl-q` |
| `Ctrl-n` | New file | `Ctrl-n` |
| `Ctrl-t` | New tab | `Ctrl-t` |
| `Ctrl-o` | Open file | `Ctrl-o` |
| `Ctrl-Shift-o` | Open in new tab | `Ctrl-Shift-o` |
| `Ctrl-p` | Quick open | `Ctrl-p` |
| `Ctrl-Shift-p` | Command palette | `Ctrl-Shift-p` |
| `Ctrl-f` | Find | `Ctrl-f` |
| `Ctrl-h` | Find and replace | `Ctrl-h` |
| `Ctrl-Shift-h` | Replace current word | `Ctrl-Shift-h` |
| `Ctrl-g` | Go to line | `Ctrl-g` |
| `Ctrl-d` | Find next occurrence | `Ctrl-d` |
| `Ctrl-Shift-d` | Find previous occurrence | `Ctrl-Shift-d` |

### VS Code-like Functions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>fd` | Format document | Auto-format current file |
| `<leader>gd` | Go to definition | Jump to symbol definition |
| `<leader>fr` | Find references | Find all references to symbol |
| `<leader>rn` | Rename symbol | Rename symbol across file |
| `<leader>ln` | Toggle line numbers | Switch absolute/relative numbers |
| `<leader>cw` | Clean whitespace | Remove trailing whitespace |
| `<leader>ts` | Toggle tabs/spaces | Switch indentation type |

---

## Basic Navigation

| Key | Action |
|-----|--------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Beginning of line |
| `$` | End of line |
| `^` | First non-blank character |
| `gg` | Go to first line |
| `G` | Go to last line |
| `:n` | Go to line n |
| `Ctrl-u` | Page up |
| `Ctrl-d` | Page down |
| `Ctrl-b` | Page up (full) |
| `Ctrl-f` | Page down (full) |

---

## File Operations

| Key | Action |
|-----|--------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:x` | Save and quit (if modified) |
| `:q!` | Quit without saving |
| `:e <file>` | Edit file |
| `:e!` | Reload current file |
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>x` | Save and quit |
| `<leader>e` | Edit file |
| `<leader>E` | Force edit file |

---

## Buffer Management

| Key | Action |
|-----|--------|
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Delete buffer |
| `:ba` | Show all buffers |
| `:ls` | List buffers |
| `:b <n>` | Go to buffer n |
| `:b <name>` | Go to buffer by name |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>ba` | Show all buffers |

---

## Window Management

| Key | Action |
|-----|--------|
| `:split` | Split horizontally |
| `:vsplit` | Split vertically |
| `:new` | New horizontal window |
| `:vnew` | New vertical window |
| `Ctrl-w h` | Move to left window |
| `Ctrl-w j` | Move to down window |
| `Ctrl-w k` | Move to up window |
| `Ctrl-w l` | Move to right window |
| `Ctrl-w w` | Cycle through windows |
| `Ctrl-w c` | Close current window |
| `Ctrl-w o` | Close other windows |
| `Ctrl-w =` | Equalize window sizes |
| `Ctrl-w _` | Maximize height |
| `Ctrl-w \|` | Maximize width |

---

## Tab Management

| Key | Action |
|-----|--------|
| `:tabnew` | New tab |
| `:tabclose` | Close current tab |
| `:tabonly` | Close other tabs |
| `:tabnext` | Next tab |
| `:tabprev` | Previous tab |
| `:tabfirst` | First tab |
| `:tablast` | Last tab |
| `gt` | Next tab |
| `gT` | Previous tab |
| `<leader>tn` | New tab |
| `<leader>tc` | Close current tab |
| `<leader>to` | Close other tabs |
| `<leader>tm` | Move tab |

---

## Search & Replace

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |
| `:s/old/new` | Replace first match in line |
| `:s/old/new/g` | Replace all matches in line |
| `:%s/old/new/g` | Replace all matches in file |
| `:%s/old/new/gc` | Replace with confirmation |
| `<leader>s` | Search and replace current word |
| `<leader>S` | Search and replace with confirmation |
| `<leader>h` | Clear search highlighting |

---

## Text Editing

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at beginning of line |
| `A` | Insert at end of line |
| `o` | New line below |
| `O` | New line above |
| `r` | Replace character |
| `R` | Replace mode |
| `x` | Delete character |
| `X` | Delete character before |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `yy` | Yank (copy) line |
| `Y` | Yank line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `Ctrl-r` | Redo |
| `.` | Repeat last command |

---

## Visual Mode

| Key | Action |
|-----|--------|
| `v` | Character visual mode |
| `V` | Line visual mode |
| `Ctrl-v` | Block visual mode |
| `d` | Delete selection |
| `y` | Yank selection |
| `>` | Indent selection |
| `<` | Unindent selection |
| `=` | Auto-indent selection |
| `:` | Command on selection |

---

## Insert Mode

| Key | Action |
|-----|--------|
| `jj` | Escape to normal mode |
| `jk` | Escape to normal mode |
| `kj` | Escape to normal mode |
| `Ctrl-a` | Go to beginning of line |
| `Ctrl-e` | Go to end of line |
| `Ctrl-b` | Move left |
| `Ctrl-f` | Move right |
| `Ctrl-w` | Delete word before |
| `Ctrl-u` | Delete to beginning of line |
| `Ctrl-k` | Delete to end of line |

---

## Command Mode

| Key | Action |
|-----|--------|
| `:` | Enter command mode |
| `q:` | Command history |
| `Ctrl-a` | Go to beginning |
| `Ctrl-e` | Go to end |
| `Ctrl-b` | Move left |
| `Ctrl-f` | Move right |
| `Ctrl-w` | Delete word before |
| `Ctrl-u` | Delete to beginning |
| `Ctrl-k` | Delete to end |
| `Tab` | Command completion |

---

## Plugin Shortcuts

### NERDTree (File Explorer Sidebar)
| Key | Action |
|-----|--------|
| `<leader>nn` | Toggle NERDTree |
| `<leader>nf` | NERDTree find current file |
| `<leader>nm` | NERDTree mirror |
| `<leader>nc` | NERDTree close |

### Tagbar (Code Structure Sidebar)
| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle Tagbar |
| `<leader>tf` | Tagbar open for current file |

### Quickfix Window
| Key | Action |
|-----|--------|
| `<leader>qo` | Open quickfix window |
| `<leader>qc` | Close quickfix window |
| `<leader>qn` | Next quickfix item |
| `<leader>qp` | Previous quickfix item |

### Location List
| Key | Action |
|-----|--------|
| `<leader>lo` | Open location list |
| `<leader>lc` | Close location list |
| `<leader>ln` | Next location item |
| `<leader>lp` | Previous location item |

### CtrlP
| Key | Action |
|-----|--------|
| `<leader>j` | CtrlP file search |
| `<leader>b` | CtrlP buffer search |
| `<leader>m` | CtrlP MRU files |

### GitGutter
| Key | Action |
|-----|--------|
| `<leader>gg` | Toggle GitGutter |

### Commentary
| Key | Action |
|-----|--------|
| `<leader>cc` | Comment/uncomment line |

---

## Custom Functions

| Key | Action |
|-----|--------|
| `<leader>ln` | Toggle absolute/relative line numbers |
| `<leader>cw` | Clean whitespace |
| `<leader>ts` | Toggle tabs/spaces |

---

## Language-Specific

### Python
- 4-space indentation
- 88-character line limit (PEP 8)

### JavaScript/TypeScript
- 2-space indentation
- 100-character line limit

### Go
- Tab indentation (4 spaces)
- 120-character line limit

### HTML/CSS
- 2-space indentation
- 120-character line limit

### YAML
- 2-space indentation
- 120-character line limit

### Markdown
- Word wrap enabled
- Spell checking enabled

---

## Utility Commands

| Key | Action |
|-----|--------|
| `<leader>n` | Toggle line numbers |
| `<leader>rn` | Toggle relative line numbers |
| `<leader>p` | Toggle paste mode |
| `<leader>H` | Quick help |
| `:set spell` | Enable spell checking |
| `:set nospell` | Disable spell checking |
| `]s` | Next spelling error |
| `[s` | Previous spelling error |
| `z=` | Spelling suggestions |

---

## Quick Reference

### Essential Commands
- `:w` - Save
- `:q` - Quit
- `:wq` - Save and quit
- `u` - Undo
- `Ctrl-r` - Redo
- `dd` - Delete line
- `yy` - Copy line
- `p` - Paste
- `/pattern` - Search
- `n` - Next search result

### Leader Key Shortcuts
- `<leader>w` - Save
- `<leader>q` - Quit
- `<leader>j` - File search
- `<leader>nn` - Toggle file tree
- `<leader>cc` - Comment line
- `<leader>h` - Clear search

### Quick Escape
- `jj`, `jk`, `kj` - Exit insert mode

---

## Tips

1. **Leader Key**: Default is `,` (comma)
2. **Relative Numbers**: Use `<leader>rn` to toggle
3. **File Navigation**: Use `<leader>j` for quick file search
4. **Buffer Navigation**: Use `<leader>bn`/`<leader>bp` for buffer switching
5. **Window Navigation**: Use `Ctrl-w` + `h/j/k/l` for window movement
6. **Search**: Use `*` to search word under cursor
7. **Undo/Redo**: `u` for undo, `Ctrl-r` for redo
8. **Repeat**: `.` repeats the last command
9. **Visual Selection**: `v` for character, `V` for line, `Ctrl-v` for block
10. **Command History**: `q:` to see command history

---

*This cheat sheet is based on your enhanced Vim configuration. For more details, see the README.md file.*
