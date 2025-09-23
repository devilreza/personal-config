-- Neovim Keymaps Configuration
-- Modern key bindings optimized for Go development

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

-- Better navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

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

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Save and quit
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)
keymap("n", "<C-q>", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

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

-- Go specific keymaps
keymap("n", "<leader>gi", ":GoImport<CR>", opts)
keymap("n", "<leader>gif", ":GoImportFill<CR>", opts)
keymap("n", "<leader>gir", ":GoImportRemove<CR>", opts)
keymap("n", "<leader>gf", ":GoFmt<CR>", opts)
keymap("n", "<leader>gF", ":GoFmt<CR>", opts)
keymap("n", "<leader>gv", ":GoVet<CR>", opts)
keymap("n", "<leader>gt", ":GoTest<CR>", opts)
keymap("n", "<leader>gT", ":GoTestFunc<CR>", opts)
keymap("n", "<leader>gc", ":GoCoverage<CR>", opts)
keymap("n", "<leader>gC", ":GoCoverageClear<CR>", opts)
keymap("n", "<leader>gd", ":GoDef<CR>", opts)
keymap("n", "<leader>gD", ":GoDefPop<CR>", opts)
keymap("n", "<leader>gr", ":GoReferrers<CR>", opts)
keymap("n", "<leader>gR", ":GoRename<CR>", opts)
keymap("n", "<leader>ge", ":GoErrCheck<CR>", opts)
keymap("n", "<leader>gl", ":GoLint<CR>", opts)
keymap("n", "<leader>gL", ":GoLint<CR>", opts)
keymap("n", "<leader>gb", ":GoBuild<CR>", opts)
keymap("n", "<leader>gB", ":GoBuild!<CR>", opts)
keymap("n", "<leader>gr", ":GoRun<CR>", opts)
keymap("n", "<leader>gR", ":GoRun!<CR>", opts)
keymap("n", "<leader>gi", ":GoInstall<CR>", opts)
keymap("n", "<leader>gI", ":GoInstall!<CR>", opts)
keymap("n", "<leader>gx", ":GoRun<CR>", opts)
keymap("n", "<leader>gX", ":GoRun!<CR>", opts)

-- Go debugging
keymap("n", "<leader>db", ":GoDebugBreakpoint<CR>", opts)
keymap("n", "<leader>dc", ":GoDebugContinue<CR>", opts)
keymap("n", "<leader>ds", ":GoDebugStep<CR>", opts)
keymap("n", "<leader>dn", ":GoDebugNext<CR>", opts)
keymap("n", "<leader>do", ":GoDebugOut<CR>", opts)

-- =============================================================================
-- LSP KEYMAPS
-- =============================================================================

-- LSP keymaps
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
keymap("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>f", function()
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

-- =============================================================================
-- NVIM-TREE KEYMAPS
-- =============================================================================

-- Nvim-tree keymaps
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>E", ":NvimTreeFindFile<CR>", opts)

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
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)
keymap("n", "<leader>n", ":set number!<CR>", opts)
keymap("n", "<leader>rn", ":set relativenumber!<CR>", opts)
keymap("n", "<leader>p", ":set paste!<CR>", opts)
keymap("n", "<leader>ts", ":set expandtab!<CR>", opts)
keymap("n", "<leader>cw", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>", opts)
