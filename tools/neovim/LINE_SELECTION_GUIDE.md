# Line Selection Guide for Neovim

## Quick Reference

### Single Line Selection

| Key | Action | Mode |
|-----|--------|------|
| `V` | Select entire current line | Normal → Visual Line |
| `vv` | Quick line selection (custom) | Normal → Visual Line |
| `yy` | Copy current line | Normal |
| `dd` | Cut current line | Normal |

### Multiple Line Selection

| Key | Action |
|-----|--------|
| `V` then `j/k` | Select multiple lines down/up |
| `V` then `5j` | Select current + 5 lines down |
| `V` then `G` | Select from current to end of file |
| `V` then `gg` | Select from current to start of file |
| `3V` | Select 3 lines starting from current |
| `Vap` | Select entire paragraph |
| `Vip` | Select inner paragraph |

## Detailed Methods

### 1. Visual Line Mode (V)
Most common method for line selection:
```
V         - Enter Visual Line mode (selects current line)
j/k       - Extend selection down/up
5j        - Extend selection 5 lines down
G         - Extend to end of file
gg        - Extend to beginning of file
```

### 2. Count + Visual Line
Select specific number of lines:
```
3V        - Select 3 lines
10V       - Select 10 lines
```

### 3. Using Line Numbers
Jump and select with line numbers:
```
V15G      - Select from current line to line 15
V15gg     - Same as above
:10,20    - Command mode: operate on lines 10-20
```

### 4. Text Object Selection
Select logical blocks:
```
Vip       - Select inner paragraph
Vap       - Select around paragraph (includes blank lines)
V{        - Select to previous blank line
V}        - Select to next blank line
```

## Operations on Selected Lines

Once lines are selected (in Visual Line mode):

| Key | Action |
|-----|--------|
| `d` | Delete selected lines |
| `y` | Yank (copy) selected lines |
| `c` | Change (delete and enter insert mode) |
| `>` | Indent right |
| `<` | Indent left |
| `=` | Auto-indent |
| `:` | Enter command for selected lines |
| `gq` | Format/wrap lines |
| `~` | Toggle case |
| `u` | Lowercase |
| `U` | Uppercase |

## Advanced Selection Techniques

### 1. Select Between Patterns
```
V/pattern<CR>   - Select from current to pattern
V?pattern<CR>   - Select from current backwards to pattern
```

### 2. Select Function/Block
```
V%              - Select to matching bracket/brace
Va{             - Select around {} block
Va(             - Select around () block
Va[             - Select around [] block
```

### 3. Marks and Selection
```
ma              - Set mark 'a'
V'a             - Select from current line to mark 'a'
```

## Custom Mappings (Already in Your Config)

Your config includes these helpful mappings:

| Mapping | Action |
|---------|--------|
| `<A-j>` | Move line down |
| `<A-k>` | Move line up |
| `>` (in visual) | Indent and reselect |
| `<` (in visual) | Outdent and reselect |

## Quick Tips

1. **Double tap v**: Some users add `vv` mapping for quick line selection:
   ```vim
   nnoremap vv V
   ```

2. **Select entire file**:
   ```
   ggVG      - Go to top, visual line, go to bottom
   :%        - In command mode, % represents all lines
   ```

3. **Select and search**:
   ```
   V3j       - Select 4 lines
   :s/old/new/g  - Replace in selected lines only
   ```

4. **Copy line without selection**:
   ```
   yy        - Copy current line (no selection needed)
   3yy       - Copy 3 lines
   ```

5. **Visual Line + Search**:
   After selecting lines, you can:
   - `/pattern` - Highlight pattern in selection
   - `:s/old/new/g` - Replace only in selected lines

## Common Workflows

### Copy Multiple Lines
```
V5j       - Select 6 lines total
y         - Yank (copy)
p         - Paste below cursor
```

### Move Lines
```
V3j       - Select 4 lines
d         - Cut
5j        - Move down 5 lines
p         - Paste
```

### Indent a Block
```
Vip       - Select paragraph
>         - Indent (stays selected)
>         - Indent again
```

### Comment Multiple Lines
```
V5j              - Select lines
:s/^/# /         - Add # at start (shell/python)
:s/^/\/\/ /      - Add // at start (C/Go/JS)
```

## Exit Visual Mode

| Key | Action |
|-----|--------|
| `Esc` | Exit Visual mode |
| `<C-c>` | Exit Visual mode |
| v` or `V` | Toggle back to Normal mode |
