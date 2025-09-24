-- Project-wide search configuration
-- Multiple methods for searching text across files

local M = {}

function M.setup()
  -- Configure grep program (prefer ripgrep if available)
  if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
    vim.opt.grepformat = "%f:%l:%c:%m"
  elseif vim.fn.executable("ag") == 1 then
    vim.opt.grepprg = "ag --vimgrep"
    vim.opt.grepformat = "%f:%l:%c:%m"
  end

  -- Create search commands
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- =============================================================================
  -- SEARCH METHODS
  -- =============================================================================

  -- Method 1: Telescope (Recommended - already configured)
  -- <leader>fg - Live grep across project
  -- <leader>fw - Search current word under cursor
  keymap("n", "<leader>fw", function()
    require("telescope.builtin").grep_string()
  end, { desc = "Search current word in project" })

  -- Method 2: Native Vim grep commands
  -- Search for word under cursor
  keymap("n", "<leader>*", ":grep! <C-R><C-W><CR>:copen<CR>", { desc = "Grep word under cursor" })
  
  -- Search with input
  keymap("n", "<leader>sg", ":grep! ", { desc = "Grep with input" })
  
  -- Search in specific file types
  keymap("n", "<leader>sG", function()
    vim.ui.input({ prompt = "Grep pattern: " }, function(pattern)
      if pattern then
        vim.ui.input({ prompt = "File pattern (e.g., *.lua): " }, function(file_pattern)
          if file_pattern then
            vim.cmd(string.format("grep! '%s' **/%s", pattern, file_pattern))
            vim.cmd("copen")
          end
        end)
      end
    end)
  end, { desc = "Grep in specific file types" })

  -- Method 3: Quickfix list navigation
  keymap("n", "[q", ":cprevious<CR>", opts)
  keymap("n", "]q", ":cnext<CR>", opts)
  keymap("n", "[Q", ":cfirst<CR>", opts)
  keymap("n", "]Q", ":clast<CR>", opts)
  keymap("n", "<leader>qo", ":copen<CR>", opts)
  keymap("n", "<leader>qc", ":cclose<CR>", opts)

  -- Method 4: Search and replace across project
  keymap("n", "<leader>sr", function()
    vim.ui.input({ prompt = "Search pattern: " }, function(search)
      if search then
        vim.ui.input({ prompt = "Replace with: " }, function(replace)
          if replace then
            -- This will populate quickfix with all matches
            vim.cmd(string.format("grep! '%s'", search))
            vim.cmd("copen")
            -- User can then use :cdo s/search/replace/g to replace in all files
            print(string.format("Use :cdo s/%s/%s/g | update", search, replace))
          end
        end)
      end
    end)
  end, { desc = "Search and replace setup" })

  -- Method 5: FZF integration (if you have fzf installed)
  if vim.fn.executable("fzf") == 1 and vim.fn.executable("rg") == 1 then
    keymap("n", "<leader>sz", function()
      vim.fn.system("rg --files | fzf")
    end, { desc = "FZF file search" })
  end

  -- =============================================================================
  -- ADVANCED SEARCH COMMANDS
  -- =============================================================================

  -- Search in git files only
  vim.api.nvim_create_user_command("GGrep", function(opts)
    local cmd = "git grep -n " .. opts.args
    local results = vim.fn.systemlist(cmd)
    local qf_list = {}
    for _, line in ipairs(results) do
      local filename, lnum, text = line:match("([^:]+):(%d+):(.*)")
      if filename then
        table.insert(qf_list, {
          filename = filename,
          lnum = tonumber(lnum),
          text = text,
        })
      end
    end
    vim.fn.setqflist(qf_list)
    vim.cmd("copen")
  end, { nargs = "+", desc = "Git grep" })

  -- Search only in modified files
  vim.api.nvim_create_user_command("GrepModified", function(opts)
    local modified_files = vim.fn.systemlist("git diff --name-only")
    if #modified_files > 0 then
      local files = table.concat(modified_files, " ")
      vim.cmd(string.format("grep! '%s' %s", opts.args, files))
      vim.cmd("copen")
    else
      print("No modified files found")
    end
  end, { nargs = "+", desc = "Grep in git modified files" })

  -- Search with preview using Telescope
  keymap("n", "<leader>sp", function()
    require("telescope.builtin").live_grep({
      preview = {
        hide_on_startup = false,
      },
      layout_config = {
        preview_width = 0.6,
      },
    })
  end, { desc = "Live grep with preview" })

  -- Search in current buffer only
  keymap("n", "<leader>sb", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
  end, { desc = "Search in current buffer" })

  -- =============================================================================
  -- VISUAL MODE SEARCH
  -- =============================================================================

  -- Search for visual selection
  keymap("v", "<leader>*", function()
    -- Yank the visual selection
    vim.cmd('normal! "vy')
    local search_term = vim.fn.getreg("v")
    -- Escape special characters
    search_term = vim.fn.escape(search_term, "\\/.*$^~[]")
    -- Execute grep
    vim.cmd(string.format("grep! '%s'", search_term))
    vim.cmd("copen")
  end, { desc = "Grep visual selection" })

  -- =============================================================================
  -- SEARCH HISTORY
  -- =============================================================================

  -- Search command history
  keymap("n", "<leader>s:", function()
    require("telescope.builtin").command_history()
  end, { desc = "Search command history" })

  -- Search search history
  keymap("n", "<leader>s/", function()
    require("telescope.builtin").search_history()
  end, { desc = "Search search history" })
end

return M