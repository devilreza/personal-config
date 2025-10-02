-- Minimal Neovim Keymaps Configuration
-- VSCode-like keybindings for beginners
--
-- =============================================================================
-- 🗝️  VSCODE-LIKE KEYBINDINGS GUIDE
-- =============================================================================
--
-- 📁 FILE MANAGEMENT:
--   Ctrl+P           - Find files (like VSCode)
--   Ctrl+Shift+P     - Command palette (Telescope)
--   Ctrl+B           - Toggle file explorer (like VSCode)
--   Ctrl+`           - Toggle terminal
--
-- 💾 SAVE & QUIT:
--   Ctrl+S           - Save file
--   Ctrl+Q           - Quit
--   Ctrl+W           - Close current tab/buffer
--
-- 📑 BUFFER NAVIGATION:
--   Tab              - Next buffer
--   Shift+Tab        - Previous buffer
--   Ctrl+1-9         - Go to buffer 1-9
--
-- 🔍 SEARCH:
--   Ctrl+F           - Search in file
--   Ctrl+Shift+F     - Search in project
--   n                - Go to next search result
--   N                - Go to previous search result
--   Escape           - Clear search highlight
--
-- 🐛 ERROR NAVIGATION (VSCode-like):
--   ]d               - Go to next error
--   [d               - Go to previous error
--   Ctrl+Shift+M     - Show all errors (Problems panel)
--   Hover over error - Show error details
--
-- ✏️  EDITING:
--   Ctrl+/           - Toggle comment (like VSCode)
--   Ctrl+D           - Select word under cursor
--   Alt+Up/Down      - Move line up/down
--   Shift+Alt+Up/Down- Duplicate line up/down
--   Ctrl+Shift+K     - Delete line
--
-- 🧭 NAVIGATION:
--   gd               - Go to definition
--   gr               - Find references
--   Ctrl+Shift+O     - Go to symbol in file
--   Ctrl+T           - Go to symbol in workspace
--
-- 🔧 GO DEVELOPMENT:
--   <Space>gr        - Run Go program
--   <Space>gb        - Build Go program
--   <Space>gt        - Run tests
--   <Space>rn        - Rename symbol
--
-- =============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =============================================================================
-- FILE MANAGEMENT (VSCode-like)
-- =============================================================================
keymap("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<C-S-p>", ":Telescope commands<CR>", { desc = "Command palette" })
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<C-`>", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

-- =============================================================================
-- SAVE & QUIT (VSCode-like)
-- =============================================================================
keymap("n", "<C-s>", ":w<CR>", { desc = "Save file" })
keymap("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file (insert mode)" })
keymap("n", "<C-q>", ":q<CR>", { desc = "Quit" })

-- Smart buffer close: if last buffer, quit instead of creating empty buffer
keymap("n", "<C-w>", function()
  local bufs = vim.fn.getbufinfo({buflisted = 1})
  if #bufs <= 1 then
    vim.cmd("quit")
  else
    vim.cmd("BufferClose")
  end
end, { desc = "Close buffer" })

keymap("n", "<C-S-w>", function()
  local bufs = vim.fn.getbufinfo({buflisted = 1})
  if #bufs <= 1 then
    vim.cmd("quit")
  else
    vim.cmd("BufferClose")
  end
end, { desc = "Close buffer (alternative)" })

-- =============================================================================
-- BUFFER NAVIGATION (Tab Management)
-- =============================================================================
keymap("n", "<Tab>", ":BufferNext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", { desc = "Previous buffer" })

-- Smart buffer close for leader key too
keymap("n", "<leader>bd", function()
  local bufs = vim.fn.getbufinfo({buflisted = 1})
  if #bufs <= 1 then
    vim.cmd("quit")
  else
    vim.cmd("BufferClose")
  end
end, { desc = "Delete buffer" })

keymap("n", "<leader>bo", ":BufferCloseAllButCurrent<CR>", { desc = "Close other buffers" })

-- Go to specific buffer by number (like Chrome/Firefox tabs)
for i = 1, 9 do
  keymap("n", "<D-" .. i .. ">", ":BufferGoto " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end

-- =============================================================================
-- SEARCH (VSCode-like)
-- =============================================================================
keymap("n", "<D-f>", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in file" })
keymap("n", "<D-S-f>", ":Telescope live_grep<CR>", { desc = "Search in project" })
-- n and N are already built-in for next/previous search
keymap("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Find and replace
keymap("n", "<D-r>", ":%s//g<Left><Left>", { desc = "Find and replace in file" })
keymap('n', '<D-S-r>', function()
  require('telescope.builtin').live_grep({
    attach_mappings = function(_, map)
      map('i', '<C-r>', function(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        vim.cmd(':%s/' .. selection.value .. '//g')
      end)
      return true
    end,
  })
end, { desc = "Find and replace in project with Telescope" })

-- =============================================================================
-- ERROR NAVIGATION (VSCode-like)
-- =============================================================================
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next error" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous error" })
keymap("n", "<C-S-m>", ":Telescope diagnostics<CR>", { desc = "Show all errors" })
-- Hover is automatic with LSP

-- =============================================================================
-- EDITING (VSCode-like)
-- =============================================================================
keymap("n", "<C-/>", ":CommentToggle<CR>", { desc = "Toggle comment" })
keymap("v", "<C-/>", ":CommentToggle<CR>", { desc = "Toggle comment" })
keymap("n", "<C-d>", "*", { desc = "Select word under cursor" })

-- Move lines up/down (VSCode Alt+Up/Down)
keymap("n", "<A-Up>", ":move .-2<CR>==", { desc = "Move line up" })
keymap("n", "<A-Down>", ":move .+1<CR>==", { desc = "Move line down" })
keymap("v", "<A-Up>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "<A-Down>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Duplicate lines (VSCode Shift+Alt+Up/Down)
keymap("n", "<S-A-Up>", ":copy .-1<CR>", { desc = "Duplicate line up" })
keymap("n", "<S-A-Down>", ":copy .<CR>", { desc = "Duplicate line down" })

-- Delete line (VSCode Ctrl+Shift+K)
keymap("n", "<C-S-k>", "dd", { desc = "Delete line" })

-- =============================================================================
-- NAVIGATION (VSCode-like)
-- =============================================================================
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "<C-S-o>", ":Telescope lsp_document_symbols<CR>", { desc = "Go to symbol in file" })
keymap("n", "<C-t>", ":Telescope lsp_workspace_symbols<CR>", { desc = "Go to symbol in workspace" })

-- =============================================================================
-- GO DEVELOPMENT (VSCode-like)
-- =============================================================================
keymap("n", "<leader>gr", ":GoRun<CR>", { desc = "Run Go program" })
keymap("n", "<leader>gb", ":GoBuild<CR>", { desc = "Build Go program" })
keymap("n", "<leader>gt", ":GoTest<CR>", { desc = "Run tests in package" })
keymap("n", "<leader>gf", ":GoTestFile<CR>", { desc = "Run tests in current file" })
keymap("n", "<leader>gc", ":GoTestFunc<CR>", { desc = "Run test function under cursor" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- =============================================================================
-- UNDO/REDO (macOS-style)
-- =============================================================================
keymap("n", "<D-z>", "u", { desc = "Undo" })
keymap("i", "<D-z>", "<C-o>u", { desc = "Undo (insert mode)" })
keymap("v", "<D-z>", "<ESC>u", { desc = "Undo (visual mode)" })
keymap("n", "<D-S-z>", "<C-r>", { desc = "Redo" })
keymap("i", "<D-S-z>", "<C-o><C-r>", { desc = "Redo (insert mode)" })
keymap("v", "<D-S-z>", "<ESC><C-r>", { desc = "Redo (visual mode)" })

-- =============================================================================
-- ADDITIONAL HELPFUL SHORTCUTS
-- =============================================================================

-- Quick escape from insert mode
keymap("i", "jj", "<Esc>", { desc = "Quick escape" })

-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window splitting (macOS-style)
keymap("n", "<D-.>", ":vsplit<CR>", { desc = "Split window vertically" })

-- Show error details (like hovering in VSCode)
keymap("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error details" })

-- Format document (like VSCode Shift+Alt+F)
keymap("n", "<S-A-f>", vim.lsp.buf.format, { desc = "Format document" })

-- =============================================================================
-- TERMINAL KEYBINDINGS
-- =============================================================================

-- Toggle terminal with Ctrl+\ (like VSCode integrated terminal)
keymap("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle floating terminal" })
keymap("i", "<C-\\>", "<Esc>:ToggleTerm<CR>", { desc = "Toggle floating terminal" })
keymap("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Toggle floating terminal" })

-- Terminal navigation
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal left window" })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal down window" })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal up window" })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal right window" })

-- Special terminals
keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Toggle lazygit" })
keymap("n", "<leader>tn", "<cmd>lua _node_toggle()<CR>", { desc = "Toggle node terminal" })
keymap("n", "<leader>tp", "<cmd>lua _python_toggle()<CR>", { desc = "Toggle python terminal" })

-- Horizontal/Vertical terminal
keymap("n", "<leader>th", ":ToggleTerm size=10 direction=horizontal<CR>", { desc = "Horizontal terminal" })
keymap("n", "<leader>tv", ":ToggleTerm size=40 direction=vertical<CR>", { desc = "Vertical terminal" })

-- =============================================================================
-- GIT BLAME
-- =============================================================================
keymap("n", "<D-g>", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git blame" })

-- =============================================================================
-- WORD MOVEMENT (Option + Arrow Keys)
-- =============================================================================
-- Option + Left Arrow: Move backward by word
keymap("n", "<A-Left>", "b", { desc = "Move backward by word" })
keymap("i", "<A-Left>", "<C-o>b", { desc = "Move backward by word (insert mode)" })
keymap("v", "<A-Left>", "b", { desc = "Move backward by word (visual mode)" })

-- Option + Right Arrow: Move forward by word
keymap("n", "<A-Right>", "w", { desc = "Move forward by word" })
keymap("i", "<A-Right>", "<C-o>w", { desc = "Move forward by word (insert mode)" })
keymap("v", "<A-Right>", "w", { desc = "Move forward by word (visual mode)" })

-- Option + Delete: Delete word backward (like macOS)
keymap("i", "<A-BS>", "<C-w>", { desc = "Delete word backward (insert mode)" })

-- =============================================================================
-- RTL/PERSIAN SUPPORT FOR PERSIAN CONTENT
-- =============================================================================
-- Toggle RTL mode using Neovim's built-in rightleft option
keymap("n", "<leader>rt", function()
  vim.wo.rightleft = not vim.wo.rightleft
  if vim.wo.rightleft then
    print("RTL mode enabled")
  else
    print("RTL mode disabled")
  end
end, { desc = "Toggle RTL mode" })

keymap("n", "<leader>re", ":set rightleft<CR>", { desc = "Enable RTL mode" })
keymap("n", "<leader>rd", ":set norightleft<CR>", { desc = "Disable RTL mode" })

-- Set Persian keymap (you can toggle between Persian and English)
keymap("n", "<leader>rp", ":set keymap=persian<CR>", { desc = "Set Persian keymap" })
keymap("n", "<leader>rE", ":set keymap=<CR>", { desc = "Set English keymap" })

-- Persian input toggle (Ctrl+^ is the standard way to toggle keymap)
keymap("i", "<C-6>", "<C-^>", { desc = "Toggle Persian/English keymap" })

-- =============================================================================
-- INFO: Press ':help key-notation' to understand key combinations
-- INFO: <C-x> = Ctrl+x, <S-x> = Shift+x, <A-x> = Alt+x, <leader> = Space by default
-- =============================================================================
