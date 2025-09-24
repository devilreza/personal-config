# Project-Wide Search Guide for Neovim

## Quick Start - Most Common Methods

### 1. **Telescope Live Grep** (Recommended)
- `<leader>fg` - Live search with preview as you type
- `<leader>fw` - Search for word under cursor
- `<leader>sp` - Live grep with larger preview window

### 2. **Quick Search**
- `<leader>*` - Search word under cursor across project
- `<leader>sg` - Search with custom pattern

## All Search Methods

### Method 1: Telescope (Most Powerful)

| Keybinding | Description |
|------------|-------------|
| `<leader>fg` | Live grep - search as you type with preview |
| `<leader>fw` | Search current word under cursor |
| `<leader>sp` | Live grep with larger preview |
| `<leader>sb` | Search only in current buffer |
| `<leader>s:` | Search command history |
| `<leader>s/` | Search search history |

**In Telescope:**
- Type to search
- `Ctrl+j/k` - Navigate results
- `Enter` - Open file
- `Ctrl+x` - Open in horizontal split
- `Ctrl+v` - Open in vertical split
- `Ctrl+u/d` - Scroll preview

### Method 2: Native Vim Grep

| Keybinding | Description |
|------------|-------------|
| `<leader>*` | Grep word under cursor |
| `<leader>sg` | Grep with input prompt |
| `<leader>sG` | Grep in specific file types |

**Example commands:**
```vim
:grep! "TODO" **/*.go     " Search TODO in all Go files
:grep! "function" .       " Search in current directory
:grep! -i "error"         " Case-insensitive search
```

### Method 3: Visual Mode Search

1. Select text in visual mode
2. Press `<leader>*` to search selection across project

### Method 4: Search and Replace

1. `<leader>sr` - Start search/replace workflow
2. Enter search pattern
3. Enter replacement
4. Use `:cdo s/search/replace/g | update` to replace all

### Method 5: Git-Aware Search

| Command | Description |
|---------|-------------|
| `:GGrep pattern` | Search only in git-tracked files |
| `:GrepModified pattern` | Search only in modified files |

## Quickfix Navigation

After any grep operation:

| Keybinding | Description |
|------------|-------------|
| `]q` | Next match |
| `[q` | Previous match |
| `]Q` | Last match |
| `[Q` | First match |
| `<leader>qo` | Open quickfix window |
| `<leader>qc` | Close quickfix window |

## Advanced Tips

### 1. **Search with File Pattern**
```vim
:grep! "TODO" **/*.{js,ts}    " Search in JS and TS files
:grep! "error" src/**/*.go    " Search in src Go files
```

### 2. **Exclude Directories**
Ripgrep automatically respects `.gitignore`. To exclude more:
```vim
:grep! "search" --glob "!node_modules" --glob "!vendor"
```

### 3. **Case Sensitivity**
- Add `-i` for case-insensitive: `:grep! -i "pattern"`
- Add `-s` for case-sensitive: `:grep! -s "Pattern"`

### 4. **Regular Expressions**
```vim
:grep! "func\s+\w+\(" **/*.go    " Find Go functions
:grep! "TODO:|FIXME:" **/*       " Find TODO or FIXME
```

### 5. **Search and Replace Across Files**
```vim
" Step 1: Search
:grep! "oldFunction" **/*.js
" Step 2: Replace in all files
:cdo s/oldFunction/newFunction/g | update
```

## Performance Tips

1. **Use Telescope** for interactive searching with preview
2. **Use ripgrep** (already configured) for fastest results
3. **Limit scope** when possible: search in specific directories or file types
4. **Use git grep** (`:GGrep`) when searching only tracked files

## Common Workflows

### Find TODOs in Project
```
<leader>fg → Type "TODO" → Enter
```

### Find Function Definition
```
<leader>fw → (cursor on function name)
```

### Replace Across Project
```
<leader>sr → Enter old text → Enter new text → :cdo command
```

### Search in Current File Only
```
<leader>sb → Type search term
```

## Troubleshooting

- **No results?** Check if you're in the right directory (`:pwd`)
- **Too many results?** Be more specific or use file patterns
- **Slow search?** Ensure ripgrep is installed (`brew install ripgrep`)
- **Permission denied?** Some directories may be protected

## Requirements

- ripgrep (rg) - Already included in your setup
- Telescope - Already configured
- Git (for git-specific searches)