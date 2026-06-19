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
--   <leader>ts       - Switch themes (Theme Manager)
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
--   Ctrl+F / Alt+F   - Search in file
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
-- 📁 CODE FOLDING (VSCode-like):
--   Ctrl+Shift+[      - Fold current block
--   Ctrl+Shift+]      - Unfold current block
--   Ctrl+Shift+/      - Toggle fold at cursor
--   Option+=          - Fold current block (macOS)
--   Option+-          - Unfold current block (macOS)
--   Ctrl+K Ctrl+0     - Fold all
--   Ctrl+K Ctrl+J     - Unfold all
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
keymap("n", "<D-p>", ":Telescope find_files<CR>", { desc = "Find files (Cmd+P, VSCode-style)" })
keymap("n", "<C-S-p>", ":Telescope commands<CR>", { desc = "Command palette" })
keymap("n", "<D-S-p>", ":Telescope commands<CR>", { desc = "Command palette (Cmd+Shift+P)" })
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>ts", ":Telescope themes<CR>", { desc = "Theme switcher (Theme Manager)" })
keymap("n", "<C-`>", "<cmd>lua _float_term_toggle()<CR>", { desc = "Toggle floating terminal" })
keymap("i", "<C-`>", "<Esc><cmd>lua _float_term_toggle()<CR>", { desc = "Toggle floating terminal (insert mode)" })
keymap("t", "<C-`>", "<C-\\><C-n><cmd>lua _float_term_toggle()<CR>", { desc = "Toggle floating terminal (terminal mode)" })

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
keymap("n", "<A-f>", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in file (Alt+F)" })
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
-- SELECTION & VISUAL MODE (VSCode-like)
-- =============================================================================

-- Enter visual mode (VSCode-style selection)
-- v - character-wise selection
-- V - line-wise selection
-- <C-v> - block selection

-- VSCode-style selection with Shift+Arrow keys
keymap("n", "<S-Left>", "v<Left>", { desc = "Select left (VSCode-style)" })
keymap("n", "<S-Right>", "v<Right>", { desc = "Select right (VSCode-style)" })
keymap("n", "<S-Up>", "v<Up>", { desc = "Select up (VSCode-style)" })
keymap("n", "<S-Down>", "v<Down>", { desc = "Select down (VSCode-style)" })

-- Extend selection in visual mode
keymap("v", "<S-Left>", "<Left>", { desc = "Extend selection left" })
keymap("v", "<S-Right>", "<Right>", { desc = "Extend selection right" })
keymap("v", "<S-Up>", "<Up>", { desc = "Extend selection up" })
keymap("v", "<S-Down>", "<Down>", { desc = "Extend selection down" })

-- Select word under cursor (VSCode Ctrl+D)
keymap("n", "<C-d>", "viw", { desc = "Select word under cursor" })
keymap("n", "<D-d>", "viw", { desc = "Select word under cursor (Cmd+D)" })

-- Select entire line (VSCode Ctrl+L)
keymap("n", "<C-l>", "V", { desc = "Select entire line" })
keymap("n", "<D-l>", "V", { desc = "Select entire line (Cmd+L)" })

-- Select all (VSCode Ctrl+A)
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })
keymap("n", "<D-a>", "ggVG", { desc = "Select all (Cmd+A)" })
keymap("v", "<C-a>", "ggVG", { desc = "Select all (visual mode)" })
keymap("v", "<D-a>", "ggVG", { desc = "Select all (visual mode, Cmd+A)" })

-- Select to end/beginning of line (VSCode Shift+End/Home)
keymap("n", "<S-Home>", "v0", { desc = "Select to beginning of line" })
keymap("n", "<S-End>", "v$", { desc = "Select to end of line" })
keymap("v", "<S-Home>", "0", { desc = "Extend to beginning of line" })
keymap("v", "<S-End>", "$", { desc = "Extend to end of line" })

-- Select to beginning/end of file (VSCode Ctrl+Shift+Home/End)
keymap("n", "<C-S-Home>", "vgg", { desc = "Select to beginning of file" })
keymap("n", "<C-S-End>", "vG", { desc = "Select to end of file" })

-- =============================================================================
-- CODE FOLDING (VSCode-like collapse/expand)
-- =============================================================================
-- Toggle fold at cursor (VSCode Ctrl+Shift+[ / Ctrl+Shift+])
keymap("n", "<C-S-[>", "zc", { desc = "Fold current block" })
keymap("n", "<C-S-]>", "zo", { desc = "Unfold current block" })
keymap("n", "<C-S-/>", "za", { desc = "Toggle fold at cursor" })

-- macOS Option key shortcuts (Option + = / Option + -)
keymap("n", "<A-=>", "zc", { desc = "Fold current block (Option+=)" })
keymap("n", "<A-->", "zo", { desc = "Unfold current block (Option+-)" })

-- Fold/Unfold all (VSCode Ctrl+K Ctrl+0 / Ctrl+K Ctrl+J)
keymap("n", "<C-k><C-0>", "zM", { desc = "Fold all" })
keymap("n", "<C-k><C-j>", "zR", { desc = "Unfold all" })

-- Standard Vim folding keymaps (also work)
-- zc - close fold
-- zo - open fold  
-- za - toggle fold
-- zR - open all folds
-- zM - close all folds

-- =============================================================================
-- EDITING (VSCode-like)
-- =============================================================================
keymap("n", "<C-/>", ":CommentToggle<CR>", { desc = "Toggle comment" })
keymap("v", "<C-/>", ":CommentToggle<CR>", { desc = "Toggle comment" })

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
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "<C-S-o>", ":Telescope lsp_document_symbols<CR>", { desc = "Go to symbol in file" })
keymap("n", "<C-t>", ":Telescope lsp_workspace_symbols<CR>", { desc = "Go to symbol in workspace" })

-- =============================================================================
-- NAVIGATION HISTORY (Go back/forward after gd, etc.)
-- =============================================================================
-- After using gd (go to definition), use these to navigate back/forward
-- Built-in Neovim: <C-o> (go back) and <C-i> (go forward) always work

-- VSCode-style: Ctrl+Left/Right for navigation history
keymap("n", "<C-Left>", "<C-o>", { desc = "Go back (after gd, like VSCode Alt+Left)" })
keymap("n", "<C-Right>", "<C-i>", { desc = "Go forward (jump list, like VSCode Alt+Right)" })
keymap("i", "<C-Left>", "<C-o><C-o>", { desc = "Go back (jump list, insert mode)" })
keymap("i", "<C-Right>", "<C-o><C-i>", { desc = "Go forward (jump list, insert mode)" })

-- Alternative: Leader-based navigation (easier to remember)
keymap("n", "<leader>o", "<C-o>", { desc = "Go back (after gd)" })
keymap("n", "<leader>i", "<C-i>", { desc = "Go forward (jump list)" })

-- macOS-style: Cmd+Left/Right (if you prefer)
keymap("n", "<D-Left>", "<C-o>", { desc = "Go back (Cmd+Left)" })
keymap("n", "<D-Right>", "<C-i>", { desc = "Go forward (Cmd+Right)" })

-- VSCode-like Cmd+Click to go to definition (macOS)
-- Cmd+Click on a symbol to jump to its definition
keymap("n", "<D-LeftMouse>", "<LeftMouse><Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition (Cmd+Click)" })
keymap("n", "<D-2-LeftMouse>", "<LeftMouse><Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition (Cmd+DoubleClick)" })
-- Alternative: Cmd+D keyboard shortcut (like VSCode Cmd+Click)
keymap("n", "<D-d>", vim.lsp.buf.definition, { desc = "Go to definition (Cmd+D, like Cmd+Click)" })

-- =============================================================================
-- GO DEVELOPMENT (VSCode-like)
-- =============================================================================
keymap("n", "<leader>gr", ":GoRun<CR>", { desc = "Run Go program" })
keymap("n", "<leader>gbb", ":GoBuild<CR>", { desc = "Build Go program" })
keymap("n", "<leader>gt", ":GoTest<CR>", { desc = "Run tests in package" })
keymap("n", "<leader>gf", ":GoTestFile<CR>", { desc = "Run tests in current file" })
keymap("n", "<leader>gcc", ":GoTestFunc<CR>", { desc = "Run test function under cursor" })

-- =============================================================================
-- REACT / TYPESCRIPT / JAVASCRIPT
-- =============================================================================
-- `<leader>j*` namespace (J for JS) — kept off `r` (Rust) and `g` (Go).
keymap("n", "<leader>jo", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true,
  })
end, { desc = "JS/TS: organize imports (ts_ls)" })

keymap("n", "<leader>jm", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.addMissingImports.ts" } },
    apply = true,
  })
end, { desc = "JS/TS: add missing imports" })

keymap("n", "<leader>ju", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.removeUnused.ts" } },
    apply = true,
  })
end, { desc = "JS/TS: remove unused" })

keymap("n", "<leader>jf", ":EslintFixAll<CR>", { desc = "ESLint: fix all in buffer" })

keymap("n", "<leader>jF", function()
  require("conform").format({ async = false, lsp_fallback = true })
end, { desc = "Format buffer (prettier via conform)" })

-- =============================================================================
-- RUST DEVELOPMENT (rustaceanvim)
-- =============================================================================
-- `runnables` / `debuggables` open a picker of cargo targets / tests at cursor.
-- `expandMacro`, `hover actions`, `openCargo`, `parentModule` are rust-analyzer
-- specific actions exposed via the :RustLsp command.
keymap("n", "<leader>rr", ":RustLsp runnables<CR>",        { desc = "Rust: runnables (run/test picker)" })
keymap("n", "<leader>rR", ":RustLsp run<CR>",              { desc = "Rust: run last runnable" })
keymap("n", "<leader>rD", ":RustLsp debuggables<CR>",      { desc = "Rust: debug picker" })
keymap("n", "<leader>rm", ":RustLsp expandMacro<CR>",      { desc = "Rust: expand macro under cursor" })
keymap("n", "<leader>rh", ":RustLsp hover actions<CR>",    { desc = "Rust: hover with actions" })
keymap("n", "<leader>ro", ":RustLsp openCargo<CR>",        { desc = "Rust: open Cargo.toml" })
keymap("n", "<leader>rP", ":RustLsp parentModule<CR>",     { desc = "Rust: go to parent module" })
keymap("n", "<leader>rj", ":RustLsp joinLines<CR>",        { desc = "Rust: join lines (smart)" })

-- Quick cargo commands in floating terminal (works without LSP)
keymap("n", "<leader>rb", ":TermExec cmd='cargo build' direction=horizontal<CR>", { desc = "Rust: cargo build" })
keymap("n", "<leader>rk", ":TermExec cmd='cargo check' direction=horizontal<CR>", { desc = "Rust: cargo check" })
keymap("n", "<leader>rc", ":TermExec cmd='cargo clippy' direction=horizontal<CR>", { desc = "Rust: cargo clippy" })
keymap("n", "<leader>rT", ":TermExec cmd='cargo test' direction=horizontal<CR>",  { desc = "Rust: cargo test (all)" })

-- =============================================================================
-- SYMBOL RENAME (VSCode F2)
-- =============================================================================
-- Rename symbol under cursor (works with LSP)
-- This will show a popup where you can type the new name
keymap("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "Rename symbol (LSP)" })

-- VSCode-style F2 for rename (most common)
keymap("n", "<F2>", function()
  vim.lsp.buf.rename()
end, { desc = "Rename symbol (F2, VSCode-style)" })

-- Alternative: Shift+F2 if F2 doesn't work
keymap("n", "<S-F2>", function()
  vim.lsp.buf.rename()
end, { desc = "Rename symbol (Shift+F2)" })

-- =============================================================================
-- LSP MANAGEMENT
-- =============================================================================
-- Restart LSP server (useful when LSP gets confused)
keymap("n", "<leader>lr", function()
  vim.cmd("LspRestart")
  vim.notify("LSP server restarted", vim.log.levels.INFO)
end, { desc = "Restart LSP server" })

-- Stop LSP server
keymap("n", "<leader>ls", function()
  vim.cmd("LspStop")
  vim.notify("LSP server stopped", vim.log.levels.INFO)
end, { desc = "Stop LSP server" })

-- Start LSP server
keymap("n", "<leader>lS", function()
  vim.cmd("LspStart")
  vim.notify("LSP server started", vim.log.levels.INFO)
end, { desc = "Start LSP server" })

-- Show LSP info
keymap("n", "<leader>li", function()
  vim.cmd("LspInfo")
end, { desc = "Show LSP info" })

-- Reload LSP (restart for current buffer)
keymap("n", "<leader>lR", function()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd("edit") -- Reload buffer to trigger LSP restart
  vim.notify("LSP reloaded", vim.log.levels.INFO)
end, { desc = "Reload LSP (force restart)" })

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

-- Trigger completion manually (like VSCode Ctrl+Space / IntelliJ Cmd+I)
keymap("i", "<D-i>", function()
  require('blink.cmp').show()
end, { desc = "Trigger completion" })

-- Check Codeium/Windsurf status
keymap("n", "<leader>cs", ":CodeiumStatus<CR>", { desc = "Check Codeium status" })
keymap("n", "<leader>ca", ":Codeium Auth<CR>", { desc = "Authenticate Codeium" })
keymap("n", "<leader>ct", ":Codeium Toggle<CR>", { desc = "Toggle Codeium on/off" })
keymap("n", "<leader>mt", ":ToggleMinuet<CR>", { desc = "Toggle Minuet AI on/off" })

-- =============================================================================
-- CODEIUM/WINDSURF INLINE SUGGESTIONS (Copilot/Cursor-style)
-- =============================================================================
-- Note: These keybindings are configured in the plugin setup
-- Tab - Accept suggestion (configured in codeium setup)
-- Alt+] - Next suggestion
-- Alt+[ - Previous suggestion
-- The suggestions appear as gray text inline as you type (like Copilot)

-- Quick escape from insert mode
keymap("i", "jj", "<Esc>", { desc = "Quick escape" })

-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- VSCode-style Tab/Shift+Tab for indenting (visual mode only)
-- Note: Tab in normal mode is used for buffer navigation
keymap("v", "<Tab>", ">gv", { desc = "Indent selection (Tab)" })
keymap("v", "<S-Tab>", "<gv", { desc = "Unindent selection (Shift+Tab)" })

-- Tab/Shift+Tab in insert mode - Smart Tab: Accept Codeium suggestion or indent
-- This checks if Codeium has a suggestion and accepts it, otherwise indents
keymap("i", "<Tab>", function()
  -- Try to get Codeium virtual text module
  local ok, codeium_vt = pcall(require, "codeium.virtual_text")
  if ok and codeium_vt then
    -- Check status to see if there's a completion available
    local status_ok, status = pcall(codeium_vt.status)
    if status_ok and status and status.state == "completions" and status.total and status.total > 0 then
      -- There's a suggestion available, accept it
      local accept_ok, accept_result = pcall(codeium_vt.accept)
      if accept_ok and accept_result then
        return accept_result
      end
    end
  end
  -- No suggestion available, indent instead
  return "<C-t>"
end, { expr = true, silent = true, desc = "Accept Codeium suggestion or indent (Tab)" })

keymap("i", "<S-Tab>", "<C-d>", { desc = "Unindent in insert mode (Shift+Tab)" })

-- Alternative: Use > and < in normal mode for single line indenting
-- (Tab in normal mode is reserved for buffer navigation)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window splitting (macOS-style)
keymap("n", "<D-.>", ":vsplit<CR>", { desc = "Split window vertically" })

-- Close window/pane (macOS-friendly)
keymap("n", "<A-w>", "<C-w>c", { desc = "Close current window/pane (macOS Option+W)" })
keymap("n", "<leader>wc", "<C-w>c", { desc = "Close current window/pane" })
keymap("n", "<leader>wq", "<C-w>q", { desc = "Close current window/pane (alternative)" })

-- Show error details (like hovering in VSCode)
keymap("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error details" })

-- Signature help (show method/function signature)
-- In insert mode: shows signature when typing function calls
keymap("i", "<C-S-Space>", vim.lsp.buf.signature_help, { desc = "Show signature help (Ctrl+Shift+Space)" })
keymap("i", "<D-S-Space>", vim.lsp.buf.signature_help, { desc = "Show signature help (Cmd+Shift+Space, VSCode-style)" })
keymap("n", "<C-S-Space>", vim.lsp.buf.signature_help, { desc = "Show signature help (Ctrl+Shift+Space)" })
keymap("n", "<D-S-Space>", vim.lsp.buf.signature_help, { desc = "Show signature help (Cmd+Shift+Space)" })

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
-- GIT FUGITIVE (Git Integration)
-- =============================================================================
-- Open Git status window
keymap("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
keymap("n", "<leader>gS", ":Gstatus<CR>", { desc = "Git status (alternative)" })

-- Git diff
keymap("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff split" })
keymap("n", "<leader>gD", ":Gvdiffsplit<CR>", { desc = "Git diff vertical split" })

-- Git commit
keymap("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
keymap("n", "<leader>gC", ":Git commit --amend<CR>", { desc = "Git commit amend" })

-- Git push/pull
keymap("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
keymap("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })

-- Git log
keymap("n", "<leader>gl", ":Glog<CR>", { desc = "Git log" })
keymap("n", "<leader>gL", ":Gllog<CR>", { desc = "Git log (all refs)" })

-- Git blame
keymap("n", "<leader>gB", ":Gblame<CR>", { desc = "Git blame" })

-- Git browse (open on GitHub/GitLab)
keymap("n", "<leader>go", ":GBrowse<CR>", { desc = "Git browse (open in browser)" })

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
-- FILE UTILITIES
-- =============================================================================

-- Move cursor to beginning of file
keymap("n", "<leader>g0", function()
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  vim.cmd("normal! zz") -- Center the line in view
end, { desc = "Go to beginning of file" })

-- Alternative: Go to beginning of file (VSCode Ctrl+Home)
keymap("n", "<C-Home>", function()
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  vim.cmd("normal! zz")
end, { desc = "Go to beginning of file (Ctrl+Home)" })
keymap("i", "<C-Home>", "<Esc>ggzzi", { desc = "Go to beginning of file (Ctrl+Home, insert mode)" })

-- Go to end of file (VSCode Ctrl+End)
keymap("n", "<C-End>", function()
  local last_line = vim.api.nvim_buf_line_count(0)
  vim.api.nvim_win_set_cursor(0, { last_line, 0 })
  vim.cmd("normal! zz")
end, { desc = "Go to end of file (Ctrl+End)" })
keymap("i", "<C-End>", "<Esc>Gzzi", { desc = "Go to end of file (Ctrl+End, insert mode)" })

-- Get first line of current file
keymap("n", "<leader>f1", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
  if #lines > 0 then
    local first_line = lines[1]
    -- Copy to clipboard
    vim.fn.setreg("+", first_line)
    vim.fn.setreg("*", first_line)
    -- Also yank to default register
    vim.fn.setreg('"', first_line)
    -- Show message
    vim.notify("First line copied: " .. first_line, vim.log.levels.INFO)
  else
    vim.notify("File is empty", vim.log.levels.WARN)
  end
end, { desc = "Get first line of file (copy to clipboard)" })

-- Get first line and print it (without copying)
keymap("n", "<leader>fp", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
  if #lines > 0 then
    print(lines[1])
  else
    print("File is empty")
  end
end, { desc = "Print first line of file" })

-- Get first line and yank it (for pasting)
keymap("n", "<leader>fy", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
  if #lines > 0 then
    vim.fn.setreg('"', lines[1])
    vim.notify("First line yanked: " .. lines[1], vim.log.levels.INFO)
  else
    vim.notify("File is empty", vim.log.levels.WARN)
  end
end, { desc = "Yank first line of file" })

-- =============================================================================
-- CODEIUM/WINDSURF INLINE SUGGESTIONS (Copilot/Cursor-style)
-- =============================================================================
-- Inline suggestions appear as gray text as you type (like Copilot/Cursor)
-- Keybindings (configured in plugin setup):
--   <Tab>      - Accept suggestion
--   <M-]>      - Next suggestion (Alt+])
--   <M-[>      - Previous suggestion (Alt+[)
-- 
-- To toggle Codeium on/off: <leader>ct
-- To toggle Minuet AI on/off: <leader>mt
-- To check status: <leader>cs
-- To authenticate: <leader>ca

-- =============================================================================
-- INFO: Press ':help key-notation' to understand key combinations
-- INFO: <C-x> = Ctrl+x, <S-x> = Shift+x, <A-x> = Alt+x, <leader> = Space by default
-- =============================================================================
