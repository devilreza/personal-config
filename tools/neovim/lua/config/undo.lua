-- Undo/Redo Configuration for Neovim
-- Enhanced undo functionality with persistent undo history

local M = {}

function M.setup()
  -- Set up persistent undo
  local undo_dir = vim.fn.stdpath("data") .. "/undo"
  
  -- Create undo directory if it doesn't exist
  if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")
  end
  
  -- Enable persistent undo
  vim.opt.undofile = true
  vim.opt.undodir = undo_dir
  
  -- Undo settings
  vim.opt.undolevels = 10000  -- Maximum number of undo levels
  vim.opt.undoreload = 10000  -- Save undo history with this many lines
  
  -- Configure swap and backup
  vim.opt.swapfile = false    -- Disable swap files (we have auto-save)
  vim.opt.backup = false      -- Disable backup files
  vim.opt.writebackup = false -- Disable write backup
  
  -- Set up better diff algorithm for undo
  vim.opt.diffopt:append("algorithm:patience")
  vim.opt.diffopt:append("indent-heuristic")
  
  -- Create user commands for undo management
  vim.api.nvim_create_user_command("UndoClear", function()
    local file = vim.fn.expand("%:p")
    if file ~= "" then
      local undo_file = undo_dir .. "/" .. file:gsub("/", "%%")
      if vim.fn.filereadable(undo_file) == 1 then
        vim.fn.delete(undo_file)
        print("Undo history cleared for current file")
      end
    end
  end, { desc = "Clear undo history for current file" })
  
  vim.api.nvim_create_user_command("UndoClearAll", function()
    local files = vim.fn.glob(undo_dir .. "/*", false, true)
    for _, file in ipairs(files) do
      vim.fn.delete(file)
    end
    print("All undo history cleared")
  end, { desc = "Clear all undo history" })
  
  -- Show undo stats
  vim.api.nvim_create_user_command("UndoStats", function()
    local stats = {
      undolevels = vim.opt.undolevels:get(),
      undofile = vim.opt.undofile:get(),
      undodir = vim.opt.undodir:get()[1],
      current_undos = vim.fn.undotree().seq_cur,
      total_undos = vim.fn.undotree().seq_last,
    }
    
    print("Undo Statistics:")
    print("  Undo levels: " .. stats.undolevels)
    print("  Persistent undo: " .. (stats.undofile and "enabled" or "disabled"))
    print("  Undo directory: " .. stats.undodir)
    print("  Current position: " .. stats.current_undos .. "/" .. stats.total_undos)
  end, { desc = "Show undo statistics" })
end

return M