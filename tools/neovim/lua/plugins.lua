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
      require("config.lsp")
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
      require("config.treesitter")
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
      require("config.gitsigns")
    end,
  },

  -- =============================================================================
  -- COMMENTS
  -- =============================================================================
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require("config.comment")
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
  -- DOCKER AND CONTAINER SUPPORT
  -- =============================================================================
  {
    "ekalinin/Dockerfile.vim",
    ft = { "dockerfile", "Dockerfile" },
  },

  -- =============================================================================
  -- PROTOCOL BUFFERS / gRPC SUPPORT
  -- =============================================================================
  {
    "towolf/vim-helm",
    ft = { "helm", "yaml" },
  },

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
  
  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("config.git-conflict")
    end,
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
  
  -- =============================================================================
  -- AI INTEGRATION - AVANTE.NVIM (CURSOR AI INTEGRATION)
  -- =============================================================================
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "claude", -- Using Claude as the AI provider
      auto_suggestions_provider = "claude", -- Use Claude for auto suggestions
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022", -- Latest Claude 3.5 Sonnet model
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 4000,
          },
        },
      },
      behaviour = {
        auto_suggestions = false, -- Enable/disable auto suggestions
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        -- Default mappings, you can customize these
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      diff = {
        autojump = true,
        list_opener = "copen",
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- =============================================================================
  -- AUTO-SAVE (Alternative plugin option - commented out)
  -- =============================================================================
  -- Uncomment this if you prefer using a plugin instead of the custom config
  -- {
  --   "pocco81/auto-save.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require("auto-save").setup({
  --       enabled = true,
  --       execution_message = {
  --         message = function()
  --           return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
  --         end,
  --         dim = 0.18,
  --         cleaning_interval = 1250,
  --       },
  --       trigger_events = {"InsertLeave", "TextChanged"},
  --       condition = function(buf)
  --         local fn = vim.fn
  --         local utils = require("auto-save.utils.data")
  --         
  --         if fn.getbufvar(buf, "&modifiable") == 1 and
  --            utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
  --           return true
  --         end
  --         return false
  --       end,
  --       write_all_buffers = false,
  --       debounce_delay = 135,
  --     })
  --   end,
  -- },
}