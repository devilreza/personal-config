-- Alternative file finding methods for when Telescope has issues
local M = {}

function M.setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  
  -- Alternative file finding methods
  -- Use built-in :find command with path
  keymap("n", "<leader>pf", ":find ", { noremap = true, desc = "Find file (built-in)" })
  
  -- Use :e with wildmenu
  keymap("n", "<leader>pe", ":e **/*", { noremap = true, desc = "Edit file with wildmenu" })
  
  -- Browse current directory
  keymap("n", "<leader>pb", ":Ex<CR>", opts)
  
  -- Use FZF if available
  if vim.fn.executable('fzf') == 1 then
    keymap("n", "<leader>pz", ":!fzf<CR>", opts)
  end
  
  -- Grep alternative using vimgrep
  keymap("n", "<leader>pg", ":vimgrep /", { noremap = true, desc = "Vimgrep search" })
  
  -- Buffer list
  keymap("n", "<leader>pl", ":ls<CR>:b ", { noremap = true, desc = "List buffers" })
end

return M