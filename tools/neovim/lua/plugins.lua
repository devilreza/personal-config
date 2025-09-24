-- Neovim Plugins Configuration
-- Modern plugin setup optimized for Go development

return {
  -- =============================================================================
  -- PLUGIN MANAGER
  -- =============================================================================
  {
    "folke/lazy.nvim",
    version = "*",
    lazy = false,
  },

  -- =============================================================================
  -- COLORSHEMES
  -- =============================================================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
      })
    end,
  },

  -- =============================================================================
  -- LSP AND COMPLETION
  -- =============================================================================
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- LSP configuration is loaded in init.lua
    end,
  },

  -- =============================================================================
  -- TREESITTER
  -- =============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      -- Treesitter configuration is loaded in init.lua
    end,
  },

  -- =============================================================================
  -- TELESCOPE
  -- =============================================================================
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",  -- Use the stable 0.1.x branch instead of old tag
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
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
      -- Load fzf extension if available
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  -- =============================================================================
  -- FILE EXPLORER
  -- =============================================================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.nvim-tree")
    end,
  },

  -- =============================================================================
  -- STATUS LINE
  -- =============================================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.lualine")
    end,
  },

  -- =============================================================================
  -- GIT INTEGRATION
  -- =============================================================================
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      -- Gitsigns configuration is loaded in init.lua
    end,
  },

  -- =============================================================================
  -- COMMENTS
  -- =============================================================================
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      -- Comment configuration is loaded in init.lua
    end,
  },

  -- =============================================================================
  -- TERMINAL
  -- =============================================================================
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("config.toggleterm")
    end,
  },

  -- =============================================================================
  -- GO DEVELOPMENT
  -- =============================================================================
  -- Note: vim-go removed due to compatibility issues with Neovim 0.11+
  -- Go development is handled by native LSP (gopls) and other plugins

  -- =============================================================================
  -- ADDITIONAL UTILITIES
  -- =============================================================================
  {
    "mbbill/undotree",
    event = "BufReadPre",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
  },
  -- indent-blankline.nvim removed due to version conflicts
  -- Use built-in Neovim indentation features instead
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- Disabled due to Neovim 0.11.x compatibility issues
  -- The plugin uses deprecated vim.treesitter.get_query API
  -- {
  --   "lewis6991/spellsitter.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require("spellsitter").setup()
  --   end,
  -- },
  
  -- Alternative: Built-in spell checking configuration
  -- Add this to your init.lua or create a separate spell config:
  -- vim.opt.spell = true
  -- vim.opt.spelllang = { 'en_us' }
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = { "markdown", "text", "gitcommit" },
  --   callback = function()
  --     vim.opt_local.spell = true
  --   end,
  -- })
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "BufReadPre",
  },
  {
    "tpope/vim-rhubarb",
    event = "BufReadPre",
  },
  {
    "tpope/vim-sleuth",
    event = "BufReadPre",
  },
  {
    "tpope/vim-unimpaired",
    event = "BufReadPre",
  },
  {
    "tpope/vim-repeat",
    event = "BufReadPre",
  },
  {
    "tpope/vim-surround",
    event = "BufReadPre",
  },
  {
    "tpope/vim-commentary",
    event = "BufReadPre",
  },
  {
    "tpope/vim-eunuch",
    event = "BufReadPre",
  },
  {
    "tpope/vim-dispatch",
    event = "BufReadPre",
  },
  {
    "tpope/vim-projectionist",
    event = "BufReadPre",
  },
  {
    "tpope/vim-dadbod",
    event = "BufReadPre",
  },
  {
    "tpope/vim-dotenv",
    event = "BufReadPre",
  },
  {
    "tpope/vim-scriptease",
    event = "BufReadPre",
  },
  {
    "tpope/vim-sensible",
    event = "BufReadPre",
  },
  {
    "tpope/vim-speeddating",
    event = "BufReadPre",
  },
  {
    "tpope/vim-tbone",
    event = "BufReadPre",
  },
  {
    "tpope/vim-vinegar",
    event = "BufReadPre",
  },
  {
    "tpope/vim-abolish",
    event = "BufReadPre",
  },
  {
    "tpope/vim-characterize",
    event = "BufReadPre",
  },
  {
    "tpope/vim-capslock",
    event = "BufReadPre",
  },
  {
    "tpope/vim-endwise",
    event = "BufReadPre",
  },
  {
    "tpope/vim-flagship",
    event = "BufReadPre",
  },
  {
    "tpope/vim-obsession",
    event = "BufReadPre",
  },
  {
    "tpope/vim-ragtag",
    event = "BufReadPre",
  },
  {
    "tpope/vim-rsi",
    event = "BufReadPre",
  },
}