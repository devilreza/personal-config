-- Git Conflict Resolution Configuration
-- Makes handling merge conflicts much easier

require("git-conflict").setup({
  default_mappings = true, -- disable buffer local mapping created by this plugin
  default_commands = true, -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  highlights = { -- They must have background color, otherwise the default color will be used
    incoming = "DiffAdd",
    current = "DiffText",
  },
})

-- Additional conflict resolution helpers
local M = {}

function M.setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- =============================================================================
  -- CONFLICT NAVIGATION
  -- =============================================================================
  
  -- Jump to next/previous conflict
  keymap("n", "[x", function()
    vim.cmd("GitConflictPrevConflict")
  end, { desc = "Previous conflict" })
  
  keymap("n", "]x", function()
    vim.cmd("GitConflictNextConflict")
  end, { desc = "Next conflict" })

  -- =============================================================================
  -- CONFLICT RESOLUTION SHORTCUTS
  -- =============================================================================
  
  -- Choose ours (current/local changes)
  keymap("n", "<leader>co", function()
    vim.cmd("GitConflictChooseOurs")
  end, { desc = "Choose our changes (current)" })
  
  -- Choose theirs (incoming changes)
  keymap("n", "<leader>ct", function()
    vim.cmd("GitConflictChooseTheirs")
  end, { desc = "Choose their changes (incoming)" })
  
  -- Choose both (keep both changes)
  keymap("n", "<leader>cb", function()
    vim.cmd("GitConflictChooseBoth")
  end, { desc = "Choose both changes" })
  
  -- Choose none (delete conflict)
  keymap("n", "<leader>cn", function()
    vim.cmd("GitConflictChooseNone")
  end, { desc = "Choose none (delete conflict)" })
  
  -- List all conflicts in quickfix
  keymap("n", "<leader>cq", function()
    vim.cmd("GitConflictListQf")
  end, { desc = "List conflicts in quickfix" })

  -- =============================================================================
  -- VISUAL MODE CONFLICT RESOLUTION
  -- =============================================================================
  
  -- In visual mode, you can select specific parts to keep
  keymap("v", "<leader>co", ":'<,'>GitConflictChooseOurs<CR>", { desc = "Keep selected as ours" })
  keymap("v", "<leader>ct", ":'<,'>GitConflictChooseTheirs<CR>", { desc = "Keep selected as theirs" })

  -- =============================================================================
  -- FUGITIVE INTEGRATION FOR 3-WAY MERGE
  -- =============================================================================
  
  -- Open 3-way diff for better conflict resolution
  keymap("n", "<leader>cd", function()
    -- Check if we're in a git repository and have conflicts
    local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
    if git_dir == "" then
      vim.notify("Not in a git repository", vim.log.levels.ERROR)
      return
    end
    
    -- Use Fugitive's 3-way diff
    vim.cmd("Gdiffsplit!")
  end, { desc = "Open 3-way merge diff" })

  -- =============================================================================
  -- CONFLICT MARKERS SEARCH
  -- =============================================================================
  
  -- Search for conflict markers
  keymap("n", "<leader>c/", function()
    vim.fn.search("^<<<<<<< \\|^======= \\|^>>>>>>> ")
  end, { desc = "Search conflict markers" })

  -- =============================================================================
  -- HELPER FUNCTIONS
  -- =============================================================================
  
  -- Function to check if current buffer has conflicts
  local function has_conflicts()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match("^<<<<<<<") or line:match("^=======") or line:match("^>>>>>>>") then
        return true
      end
    end
    return false
  end

  -- Show conflict status
  keymap("n", "<leader>cs", function()
    if has_conflicts() then
      -- Count conflicts
      local conflict_count = 0
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      for _, line in ipairs(lines) do
        if line:match("^<<<<<<<") then
          conflict_count = conflict_count + 1
        end
      end
      vim.notify(string.format("Found %d conflict(s) in current buffer", conflict_count), vim.log.levels.INFO)
    else
      vim.notify("No conflicts found in current buffer", vim.log.levels.INFO)
    end
  end, { desc = "Show conflict status" })

  -- =============================================================================
  -- AUTO COMMANDS
  -- =============================================================================
  
  -- Highlight conflict markers
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*",
    callback = function()
      -- Only in git repositories
      local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
      if git_dir ~= "" then
        -- Highlight conflict markers
        vim.fn.matchadd("ErrorMsg", "^<<<<<<<.*")
        vim.fn.matchadd("ErrorMsg", "^>>>>>>>.*")
        vim.fn.matchadd("WarningMsg", "^=======.*")
      end
    end,
  })

  -- Notify when opening file with conflicts
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
      if has_conflicts() then
        vim.notify("This file contains merge conflicts! Use ]x and [x to navigate.", vim.log.levels.WARN)
        -- Optionally jump to first conflict
        vim.fn.search("^<<<<<<<")
      end
    end,
  })
end

return M