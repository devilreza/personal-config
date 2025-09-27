-- Neovim Keymaps Configuration
-- Modern key bindings optimized for Go development
--
-- =============================================================================
-- KEYMAP REFERENCE GUIDE
-- =============================================================================
--
-- GENERAL:
--   jj/jk/kj         - Escape to normal mode
--   Ctrl+h/j/k/l     - Navigate windows
--   Ctrl+s           - Save
--   Ctrl+q           - Quit
--   Ctrl+z           - Undo
--   <leader>h        - Clear search highlight
--
-- WINDOW MANAGEMENT:
--   <leader>sv       - Split vertically
--   <leader>sh       - Split horizontally
--   <leader>sc       - Close split
--   <leader>so       - Close other splits
--
-- FILE NAVIGATION:
--   <leader>nt       - Toggle file tree
--   <leader>nf       - Find file in tree
--   <leader>ff       - Find files (Telescope)
--   <leader>fg       - Live grep
--   <leader>fb       - Buffers
--
-- GO DEVELOPMENT:
--   <leader>gb       - Go build
--   <leader>gr       - Go run
--   <leader>gt       - Go test
--   <leader>gpc      - Go package comment
--   <leader>gie      - Go if err
--   <leader>gfst     - Go fill struct
--   <leader>gf       - Go format
--
-- DIAGNOSTICS:
--   <leader>e        - Show diagnostic
--   ]d               - Next diagnostic
--   [d               - Previous diagnostic
--
-- LSP:
--   gd               - Go to definition
--   K                - Hover documentation
--   <leader>rn       - Rename symbol
--   <leader>ca       - Code action
--
-- =============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
-- Note: mapleader and maplocalleader are set in init.lua before Lazy loads

-- =============================================================================
-- GENERAL KEYMAPS
-- =============================================================================

-- Better escape
keymap("i", "jj", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Quick line selection
keymap("n", "vv", "V", opts)  -- Double tap v to select line

-- Better navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Window splitting (macOS-style)
keymap("n", "<D-.>", ":vsplit<CR>", opts)

-- Window splits
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
keymap("n", "<leader>sc", ":close<CR>", { desc = "Close current split" })
keymap("n", "<leader>so", ":only<CR>", { desc = "Close all other splits" })

-- Line navigation shortcuts
keymap("n", "H", "^", { desc = "Go to first non-blank character" })  -- Shift+H for beginning
keymap("n", "L", "$", { desc = "Go to end of line" })  -- Shift+L for end
keymap("v", "H", "^", { desc = "Go to first non-blank character" })
keymap("v", "L", "$", { desc = "Go to end of line" })

-- Word navigation using Alt/Option key
keymap("n", "<A-Left>", "b", { desc = "Move word backward" })
keymap("n", "<A-Right>", "w", { desc = "Move word forward" })
keymap("i", "<A-Left>", "<C-o>b", { desc = "Move word backward in insert mode" })
keymap("i", "<A-Right>", "<C-o>w", { desc = "Move word forward in insert mode" })
keymap("v", "<A-Left>", "b", { desc = "Move word backward in visual mode" })
keymap("v", "<A-Right>", "w", { desc = "Move word forward in visual mode" })

-- Alternative mappings using Alt/Option key
keymap("n", "<A-h>", "0", { desc = "Go to beginning of line" })
keymap("n", "<A-l>", "$", { desc = "Go to end of line" })
keymap("i", "<A-h>", "<C-o>0", { desc = "Go to beginning of line in insert mode" })
keymap("i", "<A-l>", "<C-o>$", { desc = "Go to end of line in insert mode" })

-- Home/End key mappings (if your keyboard has them)
keymap("n", "<Home>", "^", { desc = "Go to first non-blank character" })
keymap("n", "<End>", "$", { desc = "Go to end of line" })
keymap("i", "<Home>", "<C-o>^", { desc = "Go to first non-blank character in insert mode" })
keymap("i", "<End>", "<C-o>$", { desc = "Go to end of line in insert mode" })

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move lines up/down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Alternative line movement with Shift+J/K (without auto-indent)
keymap("n", "<S-Down>", ":m .+1<CR>", { desc = "Move line down" })
keymap("n", "<S-Up>", ":m .-2<CR>", { desc = "Move line up" })
keymap("v", "<S-Down>", ":m '>+1<CR>gv", { desc = "Move selection down" })
keymap("v", "<S-Up>", ":m '<-2<CR>gv", { desc = "Move selection up" })

-- Move lines in insert mode
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down in insert mode" })
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up in insert mode" })

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Save and quit
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)
keymap("n", "<C-q>", ":q<CR>", opts)
keymap("i", "<C-q>", "<ESC>:q<CR>", opts)
keymap("v", "<C-q>", "<ESC>:q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- =============================================================================
-- UNDO/REDO CONFIGURATION
-- =============================================================================

-- Option 1: Make Ctrl+Z work as undo (instead of suspending Neovim)
-- macOS-style undo/redo with Cmd+Z/Cmd+Shift+Z
keymap("n", "<D-z>", "u", opts)
keymap("i", "<D-z>", "<C-o>u", opts)
keymap("v", "<D-z>", "<ESC>u", opts)
keymap("n", "<D-S-z>", "<C-r>", opts)
keymap("i", "<D-S-z>", "<C-o><C-r>", opts)
keymap("v", "<D-S-z>", "<ESC><C-r>", opts)

-- Option 2: Keep traditional suspend, but add alternative undo mappings
-- Comment out the above and uncomment below if you prefer traditional behavior
-- keymap("n", "<C-z>", "<C-z>", opts)  -- Keep default suspend behavior

-- Ctrl+Shift+Z or Ctrl+Y for redo (common in many editors)
keymap("n", "<C-S-z>", "<C-r>", opts)
keymap("i", "<C-S-z>", "<C-o><C-r>", opts)
keymap("v", "<C-S-z>", "<ESC><C-r>", opts)
keymap("n", "<C-y>", "<C-r>", opts)
keymap("i", "<C-y>", "<C-o><C-r>", opts)

-- Additional undo/redo helpers
keymap("n", "U", "<C-r>", opts)  -- Capital U for redo (easier to type)
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)  -- Visual undo tree

-- =============================================================================
-- BUFFER MANAGEMENT
-- =============================================================================

-- Buffer navigation
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>ba", ":ball<CR>", opts)

-- =============================================================================
-- TAB MANAGEMENT
-- =============================================================================

-- Tab navigation
keymap("n", "<leader>tn", ":tabnew<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)
keymap("n", "<leader>to", ":tabonly<CR>", opts)
keymap("n", "<leader>tm", ":tabmove<CR>", opts)

-- =============================================================================
-- SEARCH AND REPLACE
-- =============================================================================

-- Search and replace
keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)
keymap("n", "<leader>S", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", opts)

-- =============================================================================
-- GO DEVELOPMENT KEYMAPS
-- =============================================================================

-- Go.nvim specific keymaps
-- Build and run
keymap("n", "<leader>gb", "<cmd>GoBuild<cr>", { desc = "Go build" })
keymap("n", "<leader>gr", "<cmd>GoRun<cr>", { desc = "Go run" })
keymap("n", "<leader>gs", "<cmd>GoStop<cr>", { desc = "Go stop" })

-- Testing
keymap("n", "<leader>gt", "<cmd>GoTest<cr>", { desc = "Go test" })
keymap("n", "<leader>gT", "<cmd>GoTestPkg<cr>", { desc = "Go test package" })
keymap("n", "<leader>gtf", "<cmd>GoTestFunc<cr>", { desc = "Go test function" })
keymap("n", "<leader>gtc", "<cmd>GoCoverage<cr>", { desc = "Go coverage" })

-- Code generation and tools
keymap("n", "<leader>ga", "<cmd>GoAlt<cr>", { desc = "Go alternate file" })
keymap("n", "<leader>gie", "<cmd>GoIfErr<cr>", { desc = "Go if err" })
keymap("n", "<leader>gfst", "<cmd>GoFillStruct<cr>", { desc = "Go fill struct" })
keymap("n", "<leader>gfsw", "<cmd>GoFillSwitch<cr>", { desc = "Go fill switch" })
keymap("n", "<leader>gpc", "<cmd>lua require('go.comment').gen()<cr>", { desc = "Go package comment" })

-- Imports and formatting
keymap("n", "<leader>gim", "<cmd>GoImport<cr>", { desc = "Go import" })
keymap("n", "<leader>gif", "<cmd>GoImports<cr>", { desc = "Go imports (organize)" })
keymap("n", "<leader>gf", "<cmd>GoFmt<cr>", { desc = "Go format" })

-- Debugging
keymap("n", "<leader>gdb", "<cmd>GoDbgStart<cr>", { desc = "Go debug start" })
keymap("n", "<leader>gds", "<cmd>GoDbgStop<cr>", { desc = "Go debug stop" })
keymap("n", "<leader>gdt", "<cmd>GoDbgTest<cr>", { desc = "Go debug test" })
keymap("n", "<leader>gdc", "<cmd>GoDbgContinue<cr>", { desc = "Go debug continue" })

-- Tags and documentation
keymap("n", "<leader>gat", "<cmd>GoAddTag<cr>", { desc = "Go add tag" })
keymap("n", "<leader>grt", "<cmd>GoRmTag<cr>", { desc = "Go remove tag" })
keymap("n", "<leader>gct", "<cmd>GoClearTag<cr>", { desc = "Go clear tag" })
keymap("n", "<leader>gd", "<cmd>GoDoc<cr>", { desc = "Go documentation" })

-- Go module commands
keymap("n", "<leader>gmt", "<cmd>GoModTidy<cr>", { desc = "Go mod tidy" })
keymap("n", "<leader>gmi", "<cmd>GoModInit<cr>", { desc = "Go mod init" })

-- Linting
keymap("n", "<leader>gl", "<cmd>GoLint<cr>", { desc = "Go lint" })
keymap("n", "<leader>gv", "<cmd>GoVet<cr>", { desc = "Go vet" })

-- =============================================================================
-- LSP AND DIAGNOSTICS KEYMAPS
-- =============================================================================

-- Diagnostic keymaps
keymap("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',
    prefix = ' ',
    scope = 'cursor',
  })
end, { desc = "Show diagnostic" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Set diagnostic loclist" })
keymap("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic (alternative)" }) -- Alternative keymap

-- LSP keymaps
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "<leader>k", vim.lsp.buf.signature_help, opts)
keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
keymap("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- LSP rename (conflicts resolved)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>fmt", function() -- Changed from <leader>f to be more explicit
  vim.lsp.buf.format { async = true }
end, opts)

-- =============================================================================
-- TELESCOPE KEYMAPS
-- =============================================================================

-- Telescope keymaps
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fc", ":Telescope colorscheme<CR>", opts)
keymap("n", "<leader>fq", ":Telescope quickfix<CR>", opts)
keymap("n", "<leader>fl", ":Telescope loclist<CR>", opts)
keymap("n", "<leader>fw", ":Telescope grep_string<CR>", opts)  -- Search word under cursor

-- =============================================================================
-- NVIM-TREE KEYMAPS
-- =============================================================================

-- Nvim-tree keymaps
keymap("n", "<leader>nt", ":NvimTreeToggle<CR>", opts) -- Changed from <leader>e to avoid conflict
keymap("n", "<leader>nf", ":NvimTreeFindFile<CR>", opts) -- Changed from <leader>E

-- =============================================================================
-- TOGGLE TERMINAL KEYMAPS
-- =============================================================================

-- Toggle terminal keymaps
keymap("n", "<leader>tt", ":ToggleTerm<CR>", opts)
keymap("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", opts)

-- =============================================================================
-- COMMENT KEYMAPS
-- =============================================================================

-- Comment keymaps
keymap("n", "<leader>/", ":CommentToggle<CR>", opts)
keymap("v", "<leader>/", ":CommentToggle<CR>", opts)


-- =============================================================================
-- UTILITY KEYMAPS
-- =============================================================================

-- Utility keymaps
keymap("n", "<leader>n", ":set number!<CR>", opts)
keymap("n", "<leader>nr", ":set relativenumber!<CR>", opts) -- Changed from <leader>rn to avoid conflict
keymap("n", "<leader>p", ":set paste!<CR>", opts)
keymap("n", "<leader>ts", ":set expandtab!<CR>", opts)
keymap("n", "<leader>cw", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>", opts)
