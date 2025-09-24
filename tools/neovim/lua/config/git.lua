-- Git integration configuration
-- Using vim-fugitive and gitsigns.nvim

local M = {}

function M.setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- =============================================================================
  -- FUGITIVE (GIT) KEYMAPS
  -- =============================================================================
  -- Using <leader>G prefix to avoid conflicts with Go commands

  -- Git status
  keymap("n", "<leader>Gs", ":Git<CR>", { desc = "Git status" })
  keymap("n", "<leader>GS", ":Git status<CR>", { desc = "Git status (verbose)" })
  
  -- Git diff
  keymap("n", "<leader>Gd", ":Gdiffsplit<CR>", { desc = "Git diff split" })
  keymap("n", "<leader>GD", ":Git diff<CR>", { desc = "Git diff" })
  
  -- Git blame
  keymap("n", "<leader>Gb", ":Git blame<CR>", { desc = "Git blame" })
  
  -- Git log
  keymap("n", "<leader>Gl", ":Git log<CR>", { desc = "Git log" })
  keymap("n", "<leader>GL", ":Git log --oneline --graph<CR>", { desc = "Git log graph" })
  
  -- Git commit
  keymap("n", "<leader>Gc", ":Git commit<CR>", { desc = "Git commit" })
  keymap("n", "<leader>GC", ":Git commit --amend<CR>", { desc = "Git commit amend" })
  
  -- Git push/pull
  keymap("n", "<leader>Gp", ":Git push<CR>", { desc = "Git push" })
  keymap("n", "<leader>GP", ":Git pull<CR>", { desc = "Git pull" })
  
  -- Git branches
  keymap("n", "<leader>GB", ":Git branch<CR>", { desc = "Git branches" })
  keymap("n", "<leader>Go", ":Git checkout<Space>", { desc = "Git checkout" })
  
  -- Git stash
  keymap("n", "<leader>Gt", ":Git stash<CR>", { desc = "Git stash" })
  keymap("n", "<leader>GT", ":Git stash pop<CR>", { desc = "Git stash pop" })
  
  -- Browse file history
  keymap("n", "<leader>Gh", ":0Gclog<CR>", { desc = "Git file history" })
  
  -- Git add
  keymap("n", "<leader>Ga", ":Git add %<CR>", { desc = "Git add current file" })
  keymap("n", "<leader>GA", ":Git add .<CR>", { desc = "Git add all" })
  
  -- Git reset
  keymap("n", "<leader>Gr", ":Git reset %<CR>", { desc = "Git reset current file" })
  keymap("n", "<leader>GR", ":Git reset<CR>", { desc = "Git reset" })

  -- =============================================================================
  -- GITSIGNS KEYMAPS
  -- =============================================================================
  -- Using ]c and [c for navigation (common convention)

  -- Navigation
  keymap("n", "]c", function()
    if vim.wo.diff then return "]c" end
    vim.schedule(function() require("gitsigns").next_hunk() end)
    return "<Ignore>"
  end, { expr = true, desc = "Next git hunk" })

  keymap("n", "[c", function()
    if vim.wo.diff then return "[c" end
    vim.schedule(function() require("gitsigns").prev_hunk() end)
    return "<Ignore>"
  end, { expr = true, desc = "Previous git hunk" })

  -- Actions
  keymap("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
  keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
  keymap("v", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
  keymap("v", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
  keymap("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
  keymap("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
  keymap("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
  keymap("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
  keymap("n", "<leader>hb", function() require("gitsigns").blame_line{full=true} end, { desc = "Blame line" })
  keymap("n", "<leader>hB", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle blame" })
  keymap("n", "<leader>hd", ":Gitsigns diffthis<CR>", { desc = "Diff this" })
  keymap("n", "<leader>hD", function() require("gitsigns").diffthis("~") end, { desc = "Diff this ~" })
  keymap("n", "<leader>ht", ":Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted" })

  -- Text object
  keymap({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })

  -- =============================================================================
  -- QUICK ACCESS
  -- =============================================================================
  
  -- Most common git operations
  keymap("n", "<leader>gg", ":Git<CR>", { desc = "Git status (fugitive)" })
  keymap("n", "<leader>gf", ":Git fetch<CR>", { desc = "Git fetch" })
  keymap("n", "<leader>gm", ":Git merge<Space>", { desc = "Git merge" })

  -- =============================================================================
  -- VISUAL MODE GIT OPERATIONS
  -- =============================================================================
  
  -- Stage/unstage visual selection
  keymap("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage selection" })
  keymap("v", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset selection" })
  
  -- =============================================================================
  -- MERGE CONFLICT HELPERS
  -- =============================================================================
  
  -- During merge conflicts in fugitive's 3-way diff
  keymap("n", "<leader>c2", ":diffget //2<CR>", { desc = "Get from target (left)" })
  keymap("n", "<leader>c3", ":diffget //3<CR>", { desc = "Get from merge (right)" })
  keymap("n", "<leader>cc", ":Gwrite<CR>", { desc = "Accept current and continue" })
  
  -- Load git-conflict configuration
  require("config.git-conflict").setup()
  
  -- Load enhanced conflict highlighting
  require("config.conflict-highlights").setup()
end

return M