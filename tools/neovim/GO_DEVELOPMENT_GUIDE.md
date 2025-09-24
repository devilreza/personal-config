# Go Development Guide for Neovim

## Overview

Your Neovim is now configured with modern Go development tools using LSP (gopls) instead of vim-go. All the familiar commands still work!

## Quick Reference

### Navigation (LSP-powered)

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>gd` | `:GoDef` | Go to definition |
| `<leader>gD` | `:GoDecl` | Go to declaration |
| `<leader>gi` | `:GoImpl` | Go to implementation |
| `<leader>gr` | `:GoRefs` | Find all references |
| `<leader>gt` | `:GoType` | Go to type definition |
| `gd` | Native LSP | Alternative: go to definition |
| `gr` | Native LSP | Alternative: find references |
| `K` | Hover | Show type info/documentation |

### Code Actions

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>gn` | `:GoRename` | Rename symbol |
| `<leader>ga` | Code action | Show available actions |
| `<leader>gf` | `:GoFmt` | Format code |
| `<leader>gi` | `:GoImports` | Organize imports |

### Build & Run

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>gb` | `:GoBuild` | Build current package |
| `<leader>gB` | `:GoBuild ./...` | Build all packages |
| `<leader>gx` | `:GoRun` | Run current file |
| `<leader>gX` | `:GoRun .` | Run current package |

### Testing

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>gtt` | `:GoTest` | Test current package |
| `<leader>gtT` | `:GoTest ./...` | Test all packages |
| `<leader>gtf` | `:GoTestFunc` | Test function at cursor |
| `<leader>gtc` | `:GoCoverage` | Run with coverage |

### Code Quality

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>gv` | `:GoVet` | Run go vet |
| `<leader>gV` | `:GoVet ./...` | Vet all packages |
| `<leader>ge` | `:GoLint` | Run golangci-lint |
| `<leader>gE` | `:GoErrCheck` | Check error handling |

### Module Management

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>gmt` | `:GoModTidy` | Run go mod tidy |
| `<leader>gmd` | `:GoModDownload` | Download dependencies |
| `<leader>gmu` | Update deps | Update all dependencies |

## Features

### 1. Auto Format & Import on Save
Go files are automatically formatted and imports are organized when you save.

### 2. Error Navigation
After running build/test commands:
- `:cn` - Next error
- `:cp` - Previous error
- `:copen` - Open error list

### 3. Code Completion
- Automatic completion as you type
- `<C-n>`/`<C-p>` - Navigate suggestions
- `<Tab>` - Accept completion

### 4. Hover Documentation
- Press `K` over any symbol to see its documentation
- Shows type information, function signatures, and doc comments

### 5. Signature Help
- `<C-k>` in insert mode shows function signature

## Common Workflows

### 1. Navigate Code
```
1. Place cursor on a function/type
2. Press <leader>gd to jump to definition
3. Press <C-o> to jump back
4. Press <leader>gr to see all usages
```

### 2. Refactor Symbol
```
1. Place cursor on symbol
2. Press <leader>gn
3. Type new name
4. Press Enter
```

### 3. Run Tests
```
# Test everything
<leader>gtT

# Test current package
<leader>gtt

# Test specific function (cursor on test)
<leader>gtf

# See coverage
<leader>gtc
```

### 4. Fix Imports
```
# Automatic on save, or manually:
<leader>gi
```

### 5. Quick Fix
```
1. See error squiggles
2. Place cursor on error
3. Press <leader>ga for quick fixes
4. Select fix from menu
```

## Debugging

If Delve is installed:
- `:GoDebug` - Start debugging current package
- `:GoDebugTest` - Debug test at cursor

Install Delve:
```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

## Tips & Tricks

1. **Jump Between Files**:
   - `<leader>ff` - Find files
   - `<leader>fg` - Grep in project
   - `<leader>fb` - Browse buffers

2. **Quick Documentation**:
   - Hover over any Go symbol and press `K`
   - Works for stdlib and third-party packages

3. **Error Checking**:
   - Red squiggles appear for compile errors
   - Yellow for warnings
   - Hover or `<leader>ga` for fixes

4. **Test Navigation**:
   - `]m` / `[m` - Next/previous method
   - Works great for jumping between test functions

5. **Struct Tags**:
   - Place cursor on struct field
   - `<leader>ga` often suggests adding tags

## Troubleshooting

**Q: `<leader>gd` shows "Not an editor command: GoDef"**
- Make sure you're in a Go file
- Restart Neovim to load the configuration

**Q: No code completion?**
- Check gopls is running: `:LspInfo`
- Install/update gopls: `go install golang.org/x/tools/gopls@latest`

**Q: Imports not organizing?**
- Ensure goimports is installed: `go install golang.org/x/tools/cmd/goimports@latest`
- Try manual: `<leader>gi`

**Q: Can't see errors?**
- Run `:LspInfo` to check gopls status
- Try `:e` to reload the file

## LSP Commands

Additional LSP commands available:
- `:LspInfo` - Show LSP status
- `:LspRestart` - Restart language server
- `:LspLog` - View LSP logs

## Required Tools

Make sure these are installed:
```bash
# Language server (required)
go install golang.org/x/tools/gopls@latest

# Linting (recommended)
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Error checking (optional)
go install github.com/kisielk/errcheck@latest

# Debugging (optional)
go install github.com/go-delve/delve/cmd/dlv@latest
```

Your Neovim is now a powerful Go IDE!