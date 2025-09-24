-- Treesitter Configuration
-- Syntax highlighting and parsing

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "go",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
    "bash",
    "python",
    "rust",
    "c",
    "cpp",
    "proto",
    -- "dockerfile", -- Temporarily disabled due to parser issues
  },
  sync_install = false,
  auto_install = true,
  ignore_install = { "dockerfile" }, -- Ignore dockerfile parser due to extraction issues
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-backspace>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})
