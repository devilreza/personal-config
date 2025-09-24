# Git Conflict Resolution Guide for Neovim

## Quick Start - Resolving Conflicts

When you encounter a merge conflict:

1. **Navigate conflicts**: `]x` (next) / `[x` (previous)
2. **Choose resolution**:
   - `<leader>co` - Choose OURS (your changes)
   - `<leader>ct` - Choose THEIRS (incoming changes)
   - `<leader>cb` - Choose BOTH (keep both)
   - `<leader>cn` - Choose NONE (delete both)

## Conflict Markers Explained

```
<<<<<<< HEAD (or branch name)
Your current changes (OURS)
=======
Incoming changes (THEIRS)
>>>>>>> branch-name
```

## All Conflict Resolution Commands

### Navigation
| Key | Command | Description |
|-----|---------|-------------|
| `]x` | Next conflict | Jump to next conflict marker |
| `[x` | Previous conflict | Jump to previous conflict marker |
| `<leader>c/` | Search conflicts | Search for conflict markers |
| `<leader>cq` | List conflicts | Show all conflicts in quickfix |
| `<leader>cs` | Conflict status | Show conflict count in buffer |

### Resolution Shortcuts
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>co` | Choose ours | Keep your version (current/HEAD) |
| `<leader>ct` | Choose theirs | Keep incoming version |
| `<leader>cb` | Choose both | Keep both versions |
| `<leader>cn` | Choose none | Delete the conflicted section |

### Advanced 3-Way Merge
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cd` | 3-way diff | Open Fugitive's 3-way merge view |
| `<leader>c2` | Get from left | In 3-way: take from target branch |
| `<leader>c3` | Get from right | In 3-way: take from merge branch |
| `<leader>cc` | Accept & write | Write current state and close diff |

## Conflict Resolution Workflows

### Method 1: Quick Resolution (Most Common)

```bash
# After git merge/rebase/cherry-pick shows conflicts
nvim conflicted-file.txt
```

In Neovim:
1. File opens, you see conflict warning
2. Press `]x` to jump to first conflict
3. Review the changes
4. Press `<leader>co` (ours) or `<leader>ct` (theirs)
5. Press `]x` to next conflict
6. Repeat until done
7. Save file with `:w`

### Method 2: 3-Way Merge (Complex Conflicts)

```bash
nvim conflicted-file.txt
```

1. Press `<leader>cd` to open 3-way diff
2. You'll see three windows:
   - LEFT: Target branch (usually main/master)
   - MIDDLE: Working copy (with conflicts)
   - RIGHT: Merge branch (incoming changes)
3. Navigate and use:
   - `:diffget //2` - Get from left (target)
   - `:diffget //3` - Get from right (merge)
   - Or use shortcuts: `<leader>c2` / `<leader>c3`
4. When done: `<leader>cc` to save and close

### Method 3: Selective Resolution

1. Navigate to conflict with `]x`
2. Enter visual mode with `V`
3. Select the specific lines you want
4. Press `<leader>co` or `<leader>ct` to keep selection

### Method 4: Manual Editing

1. Navigate to conflict
2. Manually edit the text
3. Delete conflict markers:
   - `<<<<<<< HEAD`
   - `=======`
   - `>>>>>>> branch-name`
4. Save when done

## Visual Indicators

The plugin provides visual hints:
- 🟦 **Current/Ours**: Your changes (usually blue)
- 🟩 **Incoming/Theirs**: Their changes (usually green)
- ❌ **Conflict markers**: Highlighted in red

## Common Scenarios

### Scenario 1: Simple Conflict
```
<<<<<<< HEAD
const API_URL = "https://prod.api.com"
=======
const API_URL = "https://staging.api.com"
>>>>>>> feature-branch
```
**Resolution**: Press `<leader>co` to keep prod URL

### Scenario 2: Both Changes Needed
```
<<<<<<< HEAD
import { userAuth } from './auth'
=======
import { userProfile } from './profile'
>>>>>>> feature-branch
```
**Resolution**: Press `<leader>cb` to keep both imports

### Scenario 3: Complete Rewrite
```
<<<<<<< HEAD
// Old implementation
function oldWay() { ... }
=======
// New implementation
function newWay() { ... }
>>>>>>> feature-branch
```
**Resolution**: Review carefully, then `<leader>ct` for new implementation

## Tips & Tricks

1. **Preview before choosing**: 
   - Position cursor in conflict
   - Use `<leader>hp` to preview hunk differences

2. **Undo resolution**:
   - If you make a mistake, just press `u` to undo
   - The conflict markers will reappear

3. **Check all conflicts first**:
   - `<leader>cq` to list all conflicts
   - Review the scope before starting

4. **Stage as you go**:
   - After resolving each file: `<leader>Ga`
   - Helps track progress

5. **Abort if needed**:
   - `:Git merge --abort` to cancel merge
   - `:Git rebase --abort` to cancel rebase

## After Resolution

1. **Check status**: `<leader>gg`
2. **Stage resolved files**: `<leader>GA` or `git add .`
3. **Continue operation**:
   - For merge: `<leader>Gc` to commit
   - For rebase: `:Git rebase --continue`
   - For cherry-pick: `:Git cherry-pick --continue`

## Troubleshooting

**Q: Commands not working?**
- Ensure you're in a file with actual conflicts
- Run `:Lazy sync` to update plugins

**Q: Can't see conflict highlights?**
- Check if file has conflict markers
- Try `:GitConflictRefresh`

**Q: Accidentally chose wrong option?**
- Press `u` to undo
- Or `<leader>cs` to check status

**Q: Want different colors?**
- Customize in your config:
```lua
require("git-conflict").setup({
  highlights = {
    incoming = "DiffAdd",
    current = "DiffText",
  }
})
```

## Quick Reference Card

```
Navigation:     ]x / [x
Choose Ours:    <leader>co
Choose Theirs:  <leader>ct  
Choose Both:    <leader>cb
Choose None:    <leader>cn
3-Way Diff:     <leader>cd
List All:       <leader>cq
```

Remember: Practice on a test repository first!