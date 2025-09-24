# Git Commands Guide for Neovim

## Quick Reference

### Most Used Git Commands

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>gg` | `:Git` | Git status (Fugitive) |
| `<leader>Gs` | `:Git` | Git status |
| `<leader>Ga` | `:Git add %` | Stage current file |
| `<leader>Gc` | `:Git commit` | Commit staged changes |
| `<leader>Gp` | `:Git push` | Push to remote |
| `<leader>GP` | `:Git pull` | Pull from remote |
| `<leader>Gd` | `:Gdiffsplit` | Show diff in split |
| `<leader>Gb` | `:Git blame` | Show blame |

### Hunk Operations (Gitsigns)

| Keybinding | Command | Description |
|------------|---------|-------------|
| `]c` | Next hunk | Jump to next change |
| `[c` | Previous hunk | Jump to previous change |
| `<leader>hs` | Stage hunk | Stage current hunk |
| `<leader>hr` | Reset hunk | Undo current hunk |
| `<leader>hp` | Preview hunk | Preview changes in popup |
| `<leader>hb` | Blame line | Show blame for current line |

## All Git Commands

### Fugitive Commands (Capital G prefix)

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>Gs` | `:Git` | Interactive git status |
| `<leader>GS` | `:Git status` | Git status output |
| `<leader>Gd` | `:Gdiffsplit` | Diff current file (split view) |
| `<leader>GD` | `:Git diff` | Show full diff |
| `<leader>Gb` | `:Git blame` | Blame view |
| `<leader>Gl` | `:Git log` | View log |
| `<leader>GL` | `:Git log --oneline --graph` | Pretty log |
| `<leader>Gc` | `:Git commit` | Create commit |
| `<leader>GC` | `:Git commit --amend` | Amend last commit |
| `<leader>Gp` | `:Git push` | Push changes |
| `<leader>GP` | `:Git pull` | Pull changes |
| `<leader>GB` | `:Git branch` | List branches |
| `<leader>Go` | `:Git checkout` | Checkout branch |
| `<leader>Gt` | `:Git stash` | Stash changes |
| `<leader>GT` | `:Git stash pop` | Pop stash |
| `<leader>Gh` | `:0Gclog` | File history |
| `<leader>Ga` | `:Git add %` | Stage current file |
| `<leader>GA` | `:Git add .` | Stage all files |
| `<leader>Gr` | `:Git reset %` | Unstage current file |
| `<leader>GR` | `:Git reset` | Reset staging |
| `<leader>gf` | `:Git fetch` | Fetch from remote |
| `<leader>gm` | `:Git merge` | Merge branch |

### Gitsigns Commands (Hunk operations)

| Keybinding | Command | Description |
|------------|---------|-------------|
| `]c` | Next hunk | Navigate to next change |
| `[c` | Previous hunk | Navigate to previous change |
| `<leader>hs` | Stage hunk | Stage hunk under cursor |
| `<leader>hr` | Reset hunk | Reset hunk under cursor |
| `<leader>hS` | Stage buffer | Stage entire file |
| `<leader>hR` | Reset buffer | Reset entire file |
| `<leader>hu` | Undo stage | Undo last stage |
| `<leader>hp` | Preview hunk | Preview changes |
| `<leader>hb` | Blame line | Show blame for line |
| `<leader>hB` | Toggle blame | Toggle inline blame |
| `<leader>hd` | Diff this | Diff against index |
| `<leader>hD` | Diff this ~ | Diff against last commit |
| `<leader>ht` | Toggle deleted | Show/hide deleted lines |

### Visual Mode Git Commands

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>hs` | Stage selection | Stage selected lines |
| `<leader>hr` | Reset selection | Reset selected lines |
| `ih` | Select hunk | Select hunk (text object) |

## Common Workflows

### 1. Basic Commit Workflow
```
<leader>gg    # Check status
<leader>Ga    # Stage current file (or <leader>GA for all)
<leader>Gc    # Commit with message
<leader>Gp    # Push to remote
```

### 2. Review Changes Before Commit
```
<leader>Gd    # See diff of current file
<leader>GD    # See all diffs
]c            # Navigate through changes
<leader>hp    # Preview specific change
```

### 3. Interactive Staging
```
<leader>gg    # Open Git status
(in status window)
s             # Stage file/hunk
u             # Unstage file/hunk
=             # Toggle diff
cc            # Commit
```

### 4. Fix Last Commit
```
<leader>Ga    # Stage fixes
<leader>GC    # Amend last commit
```

### 5. Stash Work
```
<leader>Gt    # Stash current changes
<leader>GT    # Pop stash back
```

### 6. Branch Operations
```
<leader>GB    # List branches
<leader>Go main    # Checkout main branch
```

## Tips

1. **In Git Status Window** (`:Git` or `<leader>gg`):
   - `s` - Stage/unstage file
   - `u` - Unstage file
   - `=` - Toggle inline diff
   - `dd` - Open file diff
   - `cc` - Commit
   - `ca` - Amend commit
   - `cp` - Cherry-pick
   - `cz` - Stash changes
   - `X` - Discard changes
   - `Enter` - Open file

2. **Diff View Navigation**:
   - `]c` / `[c` - Next/previous change
   - `:diffget` - Get change from other side
   - `:diffput` - Put change to other side
   - `:Gwrite` - Accept current version

3. **Conflict Resolution**:
   - Open conflicted file
   - `:Gdiffsplit!` - Three-way diff
   - `:diffget //2` - Get from left (target)
   - `:diffget //3` - Get from right (merge)

4. **Quick Commands**:
   - `:G` - Short for `:Git`
   - `:Gw` - Save and stage file
   - `:Gread` - Restore file from index

## Troubleshooting

- **Commands not working?** Make sure you're in a git repository
- **Can't see changes?** Try `:Gitsigns refresh`
- **Blame not showing?** Toggle with `<leader>hB`
- **Missing colors in diff?** Check your colorscheme supports git highlighting

## Note on Keybinding Conflicts

The Git commands use `<leader>G` (capital G) prefix to avoid conflicts with Go commands which use `<leader>g` (lowercase g). 

- Git: `<leader>G*` and `<leader>h*` (for hunks)
- Go: `<leader>g*`
