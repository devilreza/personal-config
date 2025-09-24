# Neovim Go Development Cheat Sheet
*Modern Neovim configuration optimized for Go development*

## Table of Contents
- [General Shortcuts](#general-shortcuts)
- [Go Development](#go-development)
- [LSP Features](#lsp-features)
- [File Navigation](#file-navigation)
- [Buffer Management](#buffer-management)
- [Window Management](#window-management)
- [Terminal](#terminal)
- [Git Integration](#git-integration)
- [Search & Replace](#search--replace)
- [Text Editing](#text-editing)
- [Visual Mode](#visual-mode)
- [Command Mode](#command-mode)
- [Plugin Shortcuts](#plugin-shortcuts)

---

## General Shortcuts

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>` | Space | Leader key |
| `<C-s>` | Save file | Quick save |
| `<C-q>` | Quit | Quick quit |
| `<leader>h` | Clear search | Clear search highlighting |
| `jj` / `jk` / `kj` | Escape | Quick escape from insert mode |

---

## Go Development

### Go Commands
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gi` | Go import | Auto import management |
| `<leader>gif` | Go import fill | Fill missing imports |
| `<leader>gir` | Go import remove | Remove unused imports |
| `<leader>gf` | Go format | Format code with gofmt |
| `<leader>gF` | Go format | Format code with gofumpt |
| `<leader>gv` | Go vet | Run go vet |
| `<leader>gt` | Go test | Run tests |
| `<leader>gT` | Go test function | Run test for current function |
| `<leader>gc` | Go coverage | Show test coverage |
| `<leader>gC` | Go coverage clear | Clear coverage |
| `<leader>gd` | Go definition | Go to definition |
| `<leader>gD` | Go definition pop | Pop definition stack |
| `<leader>gr` | Go referrers | Find references |
| `<leader>gR` | Go rename | Rename symbol |
| `<leader>ge` | Go errcheck | Check for errors |
| `<leader>gl` | Go lint | Run linter |
| `<leader>gb` | Go build | Build project |
| `<leader>gB` | Go build! | Build and run |
| `<leader>gr` | Go run | Run current file |
| `<leader>gR` | Go run! | Run with args |
| `<leader>gi` | Go install | Install package |
| `<leader>gI` | Go install! | Install with args |
| `<leader>gx` | Go run | Run current file |
| `<leader>gX` | Go run! | Run with args |

### Go Debugging
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>db` | Go debug breakpoint | Set breakpoint |
| `<leader>dc` | Go debug continue | Continue execution |
| `<leader>ds` | Go debug step | Step into |
| `<leader>dn` | Go debug next | Step over |
| `<leader>do` | Go debug out | Step out |

---

## LSP Features

| Key | Action | Description |
|-----|--------|-------------|
| `gD` | Declaration | Go to declaration |
| `gd` | Definition | Go to definition |
| `K` | Hover | Show hover information |
| `gi` | Implementation | Go to implementation |
| `<C-k>` | Signature help | Show signature help |
| `<leader>wa` | Add workspace folder | Add workspace folder |
| `<leader>wr` | Remove workspace folder | Remove workspace folder |
| `<leader>wl` | List workspace folders | List workspace folders |
| `<leader>D` | Type definition | Go to type definition |
| `<leader>rn` | Rename | Rename symbol |
| `<leader>ca` | Code action | Code actions |
| `gr` | References | Find references |
| `<leader>f` | Format | Format document |

---

## File Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Toggle file explorer | Open/close Nvim-tree |
| `<leader>E` | Find file in explorer | Find current file in tree |
| `<leader>ff` | Find files | Telescope find files |
| `<leader>fg` | Live grep | Telescope live grep |
| `<leader>fb` | Find buffers | Telescope buffers |
| `<leader>fh` | Help tags | Telescope help tags |
| `<leader>fr` | Recent files | Telescope oldfiles |
| `<leader>fc` | Colorscheme | Telescope colorscheme |
| `<leader>fq` | Quickfix | Telescope quickfix |
| `<leader>fl` | Location list | Telescope loclist |

---

## Buffer Management

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>bn` | Next buffer | Switch to next buffer |
| `<leader>bp` | Previous buffer | Switch to previous buffer |
| `<leader>bd` | Delete buffer | Delete current buffer |
| `<leader>ba` | Show all buffers | Show all buffers |

---

## Window Management

| Key | Action | Description |
|-----|--------|-------------|
| `<C-h>` | Move left | Move to left window |
| `<C-j>` | Move down | Move to down window |
| `<C-l>` | Move right | Move to right window |
| `<C-Up>` | Resize up | Resize window up |
| `<C-Down>` | Resize down | Resize window down |
| `<C-Left>` | Resize left | Resize window left |
| `<C-Right>` | Resize right | Resize window right |

---

## Terminal

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tt` | Toggle terminal | Toggle terminal |
| `<leader>tf` | Float terminal | Toggle float terminal |
| `<leader>th` | Horizontal terminal | Toggle horizontal terminal |
| `<leader>tv` | Vertical terminal | Toggle vertical terminal |
| `<C-\>` | Toggle terminal | Toggle terminal (default) |

---

## Git Integration

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gg` | Git status | Show git status |
| `<leader>gd` | Git diff | Show git diff |
| `<leader>gb` | Git blame | Show git blame |
| `<leader>gl` | Git log | Show git log |
| `<leader>gp` | Git push | Push to remote |
| `<leader>gP` | Git pull | Pull from remote |

---

## Search & Replace

| Key | Action | Description |
|-----|--------|-------------|
| `/` | Search forward | Search pattern forward |
| `?` | Search backward | Search pattern backward |
| `n` | Next match | Go to next match |
| `N` | Previous match | Go to previous match |
| `*` | Search word forward | Search word under cursor forward |
| `#` | Search word backward | Search word under cursor backward |
| `<leader>s` | Search and replace | Search and replace current word |
| `<leader>S` | Search and replace confirm | Search and replace with confirmation |

---

## Text Editing

| Key | Action | Description |
|-----|--------|-------------|
| `i` | Insert before cursor | Insert mode before cursor |
| `a` | Insert after cursor | Insert mode after cursor |
| `I` | Insert at line start | Insert at beginning of line |
| `A` | Insert at line end | Insert at end of line |
| `o` | New line below | Create new line below |
| `O` | New line above | Create new line above |
| `r` | Replace character | Replace character under cursor |
| `R` | Replace mode | Enter replace mode |
| `x` | Delete character | Delete character under cursor |
| `X` | Delete character before | Delete character before cursor |
| `dd` | Delete line | Delete current line |
| `D` | Delete to end | Delete to end of line |
| `yy` | Yank line | Copy current line |
| `Y` | Yank line | Copy current line |
| `p` | Paste after | Paste after cursor |
| `P` | Paste before | Paste before cursor |
| `u` | Undo | Undo last change |
| `<C-r>` | Redo | Redo last change |
| `.` | Repeat | Repeat last command |

---

## Visual Mode

| Key | Action | Description |
|-----|--------|-------------|
| `v` | Character visual | Character visual mode |
| `V` | Line visual | Line visual mode |
| `<C-v>` | Block visual | Block visual mode |
| `d` | Delete selection | Delete selected text |
| `y` | Yank selection | Copy selected text |
| `>` | Indent selection | Indent selected text |
| `<` | Unindent selection | Unindent selected text |
| `=` | Auto-indent selection | Auto-indent selected text |

---

## Command Mode

| Key | Action | Description |
|-----|--------|-------------|
| `:` | Enter command mode | Enter command mode |
| `q:` | Command history | Show command history |
| `<C-a>` | Go to beginning | Go to beginning of line |
| `<C-e>` | Go to end | Go to end of line |
| `<C-b>` | Move left | Move left in command line |
| `<C-f>` | Move right | Move right in command line |
| `<Tab>` | Command completion | Complete command |

---

## Plugin Shortcuts

### Comment
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>/` | Toggle comment | Toggle comment on line/selection |

### Undotree
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>u` | Toggle undotree | Show undo tree |

### Utility
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>n` | Toggle line numbers | Toggle line numbers |
| `<leader>rn` | Toggle relative numbers | Toggle relative line numbers |
| `<leader>p` | Toggle paste mode | Toggle paste mode |
| `<leader>ts` | Toggle tabs/spaces | Toggle indentation type |
| `<leader>cw` | Clean whitespace | Remove trailing whitespace |



---

## Quick Reference

### Essential Commands
- `:w` - Save
- `:q` - Quit
- `:wq` - Save and quit
- `u` - Undo
- `<C-r>` - Redo
- `dd` - Delete line
- `yy` - Copy line
- `p` - Paste
- `/pattern` - Search
- `n` - Next search result

### Leader Key Shortcuts
- `<leader>e` - File explorer
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>tt` - Toggle terminal
- `<leader>gi` - Go import
- `<leader>gt` - Go test
- `<leader>gd` - Go definition

### Go Development Workflow
1. `<leader>e` - Open file explorer
2. `<leader>ff` - Find and open Go files
3. `<leader>gi` - Auto import dependencies
4. `<leader>gt` - Run tests
5. `<leader>gd` - Navigate to definitions
6. `<leader>gr` - Find references
7. `<leader>gR` - Rename symbols

---

*This cheat sheet is based on your Neovim Go development configuration. For more details, see the README.md file.*
