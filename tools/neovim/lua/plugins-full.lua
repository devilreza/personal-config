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
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
      require("nord").set()
      vim.cmd("colorscheme nord")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 999,
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
    tag = "0.1.8",  -- Use a specific stable tag
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
  -- ICONS
  -- =============================================================================
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Check if we can use glyph style (requires Nerd Font)
      local has_nerd_font = vim.fn.has('gui_running') == 1 or os.getenv('TERM_PROGRAM') == 'iTerm.app' or vim.env.TERM == 'xterm-kitty'

      -- Setup mini.icons with proper configuration
      require("mini.icons").setup({
        style = has_nerd_font and "glyph" or "ascii", -- Use glyph if Nerd Font available, otherwise ASCII
        -- Override some common icons for better visibility
        default = { glyph = '󰈔', hl = 'MiniIconsFile' },
        directory = { glyph = '󰉋', hl = 'MiniIconsDirectory' },
        extension = {
          lua = { glyph = '󰢱', hl = 'MiniIconsBlue' },
          go = { glyph = '󰟓', hl = 'MiniIconsCyan' },
          js = { glyph = '󰌞', hl = 'MiniIconsYellow' },
          ts = { glyph = '󰛦', hl = 'MiniIconsBlue' },
          json = { glyph = '󰘦', hl = 'MiniIconsYellow' },
          md = { glyph = '󰍔', hl = 'MiniIconsBlue' },
          yaml = { glyph = '󰈙', hl = 'MiniIconsOrange' },
          yml = { glyph = '󰈙', hl = 'MiniIconsOrange' },
        },
      })
      -- Make mini.icons work with plugins that expect nvim-web-devicons API
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },

  -- =============================================================================
  -- FILE EXPLORER
  -- =============================================================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "echasnovski/mini.nvim",
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
      "echasnovski/mini.nvim",
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
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua", -- Floating window support
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Go.nvim configuration
        goimports = 'gopls', -- Use gopls for imports
        gofmt = 'gofumpt',   -- Use gofumpt for formatting
        -- max_line_len only works with golines, removed to avoid warning
        tag_transform = false, -- Don't transform tags
        test_dir = '',       -- Test directory pattern
        comment_placeholder = '   ',
        lsp_cfg = true,      -- Enable LSP config
        lsp_gofumpt = true,  -- Use gofumpt in LSP
        lsp_on_attach = true, -- Use default on_attach
        dap_debug = true,    -- Enable DAP debug support
        dap_debug_gui = true, -- Enable DAP debug GUI
        icons = { -- Use mini.icons compatible icons
          breakpoint = '🔴',
          currentpos = '▶️',
        },
        -- Diagnostic settings
        lsp_diag_hdlr = true,
        lsp_diag_underline = true,
        lsp_diag_virtual_text = { space = 0, prefix = '■' },
        lsp_diag_signs = true,
        lsp_diag_update_in_insert = false,
        -- Inlay hints
        lsp_inlay_hints = {
          enable = true,
          style = 'eol', -- 'eol' or 'inlay'
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_variable_name = true,
          parameter_hints_prefix = "󰊕 ",
          show_parameter_hints = true,
          prefix_parameter_hints = false,
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 6,
          highlight = "Comment",
        },
        -- Test settings
        run_in_floaterm = true, -- Run tests in floating terminal
        floaterm = {
          posititon = 'auto', -- Position of floating terminal
          width = 0.45,
          height = 0.98,
        },
        trouble = true, -- Enable trouble.nvim integration
        luasnip = true, -- Enable luasnip integration
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- Install/update all binaries
  },

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