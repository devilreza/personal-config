-- Enhanced conflict marker highlighting
-- Makes merge conflicts impossible to miss

local M = {}

function M.setup()
  -- Define custom highlight groups for conflict markers
  vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = "#2f3d44", fg = "#ff5555", bold = true })
  vim.api.nvim_set_hl(0, "ConflictMarkerSeparator", { bg = "#3f3d44", fg = "#ffaa55", bold = true })
  vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = "#2f3d44", fg = "#55ff55", bold = true })
  vim.api.nvim_set_hl(0, "ConflictMarkerCommon", { bg = "#3f2d44", fg = "#aa55ff", bold = true })
  
  -- Set up syntax matching for conflict markers
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*",
    callback = function()
      -- Match conflict markers with better visibility
      vim.cmd([[
        syn match ConflictMarkerBegin "^<<<<<<< .*$"
        syn match ConflictMarkerSeparator "^=======.*$"
        syn match ConflictMarkerEnd "^>>>>>>> .*$"
        syn match ConflictMarkerCommon "^||||||| .*$"
      ]])
    end,
  })

  -- Add signs in the sign column for conflicts
  vim.fn.sign_define("ConflictBegin", { text = "<<", texthl = "ConflictMarkerBegin" })
  vim.fn.sign_define("ConflictMiddle", { text = "==", texthl = "ConflictMarkerSeparator" })
  vim.fn.sign_define("ConflictEnd", { text = ">>", texthl = "ConflictMarkerEnd" })
  
  -- Function to place signs at conflict markers
  local function place_conflict_signs()
    -- Clear existing signs
    vim.fn.sign_unplace("ConflictSigns")
    
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    
    for i, line in ipairs(lines) do
      if line:match("^<<<<<<<") then
        vim.fn.sign_place(0, "ConflictSigns", "ConflictBegin", bufnr, { lnum = i })
      elseif line:match("^=======") then
        vim.fn.sign_place(0, "ConflictSigns", "ConflictMiddle", bufnr, { lnum = i })
      elseif line:match("^>>>>>>>") then
        vim.fn.sign_place(0, "ConflictSigns", "ConflictEnd", bufnr, { lnum = i })
      end
    end
  end
  
  -- Auto-place signs when entering buffer with conflicts
  vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
    pattern = "*",
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      for _, line in ipairs(lines) do
        if line:match("^<<<<<<<") then
          place_conflict_signs()
          break
        end
      end
    end,
  })
end

return M