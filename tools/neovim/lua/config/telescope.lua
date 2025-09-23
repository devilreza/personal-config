-- Telescope Configuration
-- Fuzzy finder and file navigation

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

-- Load fzf native
require("telescope").load_extension("fzf")
