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
| `gD` | Go to Declaration | Jump to declaration |
| `gi` | Go to Implementation | Jump to implementation |
| `gt` | Go to Type Definition | Jump to type definition |
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

## 📦 CODE FOLDING

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+Shift+[` | Fold Block | Fold current code block |
| `Ctrl+Shift+]` | Unfold Block | Unfold current code block |
| `Ctrl+Shift+/` | Toggle Fold | Toggle fold at cursor |
| `Option+=` | Fold Block | Fold current block (macOS) |
| `Option+-` | Unfold Block | Unfold current block (macOS) |
| `Ctrl+K Ctrl+0` | Fold All | Close all folds in file |
| `Ctrl+K Ctrl+J` | Unfold All | Open all folds in file |

### Standard Vim Folding Commands
- `zc` - Close fold (fold current block)
- `zo` - Open fold (unfold current block)
- `za` - Toggle fold (open/close at cursor)
- `zR` - Open all folds (unfold everything)
- `zM` - Close all folds (fold everything)

**Note**: Folding is automatically enabled using TreeSitter for smart code folding based on syntax.

---

## 🔀 GIT INTEGRATION (Vim-Fugitive)

| Key | Action | Description |
|-----|--------|-------------|
| `Space+gs` | Git Status | Open Git status window |
| `Space+gd` | Git Diff | Show diff in split window |
| `Space+gD` | Git Diff Vertical | Show diff in vertical split |
| `Space+gc` | Git Commit | Open commit message editor |
| `Space+gC` | Git Commit Amend | Amend last commit |
| `Space+gp` | Git Push | Push to remote |
| `Space+gP` | Git Pull | Pull from remote |
| `Space+gl` | Git Log | View commit log |
| `Space+gB` | Git Blame | Show blame information |
| `Space+go` | Git Browse | Open file/commit in browser |
| `Space+gg` | Lazygit | Open Lazygit terminal |

### Resolving Git Rebase Conflicts with Vim-Fugitive

When you encounter conflicts during a rebase, vim-fugitive makes it easy to resolve them:

#### Step 1: Start the Rebase
```bash
# In terminal or using :Git rebase <branch>
git rebase main
```

#### Step 2: When Conflicts Occur
1. **Open Git Status**: Press `Space+gs` (or `:Git` or `:Gstatus`)
   - This opens the fugitive status window showing conflicted files

2. **Navigate to Conflicted Files**:
   - In the status window, you'll see files marked with `UU` (unmerged)
   - Move cursor to a conflicted file and press `Enter` to open it

#### Step 3: Resolve Conflicts in the File
When you open a conflicted file, you'll see conflict markers:
```
<<<<<<< HEAD
Your changes
=======
Incoming changes
>>>>>>> branch-name
```

**Options to resolve:**

1. **Use 3-way diff view** (Recommended):
   - In the status window, press `dv` on the conflicted file
   - This opens a 3-way diff showing:
     - Left: Your version (HEAD)
     - Middle: The merged result (edit this)
     - Right: Incoming version
   - Edit the middle window to create the final version
   - Save with `:w`

2. **Manual resolution**:
   - Edit the file directly
   - Remove conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
   - Keep the code you want
   - Save with `:w`

3. **Choose one side entirely**:
   - In status window, press `:diffget //2` to take incoming (theirs)
   - Or press `:diffget //3` to take your version (ours)
   - Or use `:Gread` to read from a specific version

#### Step 4: Stage the Resolved File
1. Go back to status window (`Space+gs`)
2. Press `s` on the resolved file to stage it
   - Or use `:Gwrite` to stage the current file

#### Step 5: Continue the Rebase
1. In the status window, press `R` to continue the rebase
   - Or use `:Git rebase --continue` in command mode
   - Or run `git rebase --continue` in terminal

#### Step 6: If More Conflicts Appear
- Repeat steps 2-5 for each conflicted commit

#### Useful Commands During Rebase

| Command | Action |
|---------|--------|
| `:Git rebase --continue` | Continue rebase after resolving conflicts |
| `:Git rebase --abort` | Abort the rebase and return to original state |
| `:Git rebase --skip` | Skip current commit (use carefully) |
| `dv` (in status) | Open 3-way diff for conflicted file |
| `s` (in status) | Stage/unstage file |
| `:Gwrite` | Stage current file |
| `:Gread` | Discard changes, read from index |

#### Tips:
- **3-way diff is powerful**: Use `dv` in status window for visual conflict resolution
- **Quick navigation**: Use `]c` and `[c` to jump between conflict markers
- **See both versions**: The diff view shows all three versions side-by-side
- **Undo resolution**: Use `:Gread` to reset and start over

---

## 🔧 GO DEVELOPMENT

| Key | Action | Description |
|-----|--------|-------------|
| `Space+gr` | Run Go Program | Execute current Go file |
| `Space+gbb` | Build Go Program | Build Go project |
| `Space+gt` | Run Tests | Execute Go tests in package |
| `Space+gf` | Run Test File | Execute tests in current file |
| `Space+gcc` | Run Test Func | Execute test function under cursor |
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

- **Theme**: Monokai Pro
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