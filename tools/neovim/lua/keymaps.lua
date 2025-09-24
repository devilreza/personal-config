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

-- Quick line selection
keymap("n", "vv", "V", opts)  -- Double tap v to select line

-- Better navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Line navigation shortcuts
keymap("n", "H", "^", { desc = "Go to first non-blank character" })  -- Shift+H for beginning
keymap("n", "L", "$", { desc = "Go to end of line" })  -- Shift+L for end
keymap("v", "H", "^", { desc = "Go to first non-blank character" })
keymap("v", "L", "$", { desc = "Go to end of line" })

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
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- =============================================================================
-- UNDO/REDO CONFIGURATION
-- =============================================================================

-- Option 1: Make Ctrl+Z work as undo (instead of suspending Neovim)
keymap("n", "<C-z>", "u", opts)
keymap("i", "<C-z>", "<C-o>u", opts)
keymap("v", "<C-z>", "<ESC>u", opts)

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

-- Go specific keymaps using LSP and terminal commands
-- Navigation (using LSP)
keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- Code actions and refactoring
keymap("n", "<leader>gn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ga", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap("n", "<leader>gf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format code" })

-- Go specific commands using terminal
keymap("n", "<leader>gb", ":!go build %:p:h<CR>", { desc = "Go build current package" })
keymap("n", "<leader>gB", ":!go build ./...<CR>", { desc = "Go build all packages" })
keymap("n", "<leader>gx", ":!go run %<CR>", { desc = "Go run current file" })
keymap("n", "<leader>gX", ":!go run .<CR>", { desc = "Go run current package" })
keymap("n", "<leader>gv", ":!go vet %:p:h<CR>", { desc = "Go vet current package" })
keymap("n", "<leader>gV", ":!go vet ./...<CR>", { desc = "Go vet all packages" })

-- Testing
keymap("n", "<leader>gtt", ":!go test %:p:h<CR>", { desc = "Go test current package" })
keymap("n", "<leader>gtT", ":!go test ./...<CR>", { desc = "Go test all packages" })
keymap("n", "<leader>gtf", function()
  local function_name = vim.fn.expand("<cword>")
  vim.cmd(string.format("!go test %s -run %s", vim.fn.expand("%:p:h"), function_name))
end, { desc = "Go test function under cursor" })
keymap("n", "<leader>gtc", ":!go test -cover %:p:h<CR>", { desc = "Go test with coverage" })
keymap("n", "<leader>gtC", ":!go test -coverprofile=coverage.out %:p:h && go tool cover -html=coverage.out<CR>", { desc = "Go test coverage report" })

-- Go module commands
keymap("n", "<leader>gmt", ":!go mod tidy<CR>", { desc = "Go mod tidy" })
keymap("n", "<leader>gmd", ":!go mod download<CR>", { desc = "Go mod download" })
keymap("n", "<leader>gmu", ":!go get -u ./...<CR>", { desc = "Go update dependencies" })

-- Go tools
keymap("n", "<leader>ge", ":!golangci-lint run %:p:h<CR>", { desc = "Run golangci-lint" })
keymap("n", "<leader>gE", ":!golangci-lint run ./...<CR>", { desc = "Run golangci-lint all" })

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
keymap("n", "<leader>fw", ":Telescope grep_string<CR>", opts)  -- Search word under cursor

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
-- AVANTE.NVIM (AI INTEGRATION) KEYMAPS
-- =============================================================================

-- Avante AI keymaps
keymap("n", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "avante: ask" })
keymap("v", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "avante: ask" })
keymap("n", "<leader>ar", "<cmd>AvanteRefresh<cr>", { desc = "avante: refresh" })
keymap("n", "<leader>ae", "<cmd>AvanteEdit<cr>", { desc = "avante: edit" })
keymap("v", "<leader>ae", "<cmd>AvanteEdit<cr>", { desc = "avante: edit" })
keymap("n", "<leader>ac", "<cmd>AvanteChat<cr>", { desc = "avante: chat" })
keymap("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "avante: toggle" })
keymap("n", "<leader>af", "<cmd>AvanteFocus<cr>", { desc = "avante: focus" })
keymap("n", "<leader>as", "<cmd>AvanteClear<cr>", { desc = "avante: clear" })

-- Additional AI helper commands
keymap("n", "<leader>ai", "<cmd>AvanteImplement<cr>", { desc = "avante: implement" })
keymap("v", "<leader>ai", "<cmd>AvanteImplement<cr>", { desc = "avante: implement" })
keymap("n", "<leader>ad", "<cmd>AvanteDebug<cr>", { desc = "avante: debug" })
keymap("n", "<leader>ax", "<cmd>AvanteExplain<cr>", { desc = "avante: explain" })
keymap("v", "<leader>ax", "<cmd>AvanteExplain<cr>", { desc = "avante: explain" })

-- =============================================================================
-- UTILITY KEYMAPS
-- =============================================================================

-- Utility keymaps
keymap("n", "<leader>n", ":set number!<CR>", opts)
keymap("n", "<leader>rn", ":set relativenumber!<CR>", opts)
keymap("n", "<leader>p", ":set paste!<CR>", opts)
keymap("n", "<leader>ts", ":set expandtab!<CR>", opts)
keymap("n", "<leader>cw", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>", opts)
