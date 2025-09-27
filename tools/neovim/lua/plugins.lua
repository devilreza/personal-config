-- Minimal Neovim Plugins Configuration
-- VSCode-like experience for beginners
-- Focus: Error highlighting, essential features only

return {
  -- =============================================================================
  -- ESSENTIAL PLUGINS ONLY
  -- =============================================================================

  -- Plugin Manager (Required)
  {
    "folke/lazy.nvim",
    version = "*",
    lazy = false,
  },

  -- Catppuccin Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "frappe",
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
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = {
            enabled = true,
          },
          lsp_trouble = false,
          mason = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- LSP Configuration (Essential for error highlighting)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",           -- Autocompletion
      "hrsh7th/cmp-nvim-lsp",       -- LSP completion
      "hrsh7th/cmp-buffer",         -- Buffer completion
      "L3MON4D3/LuaSnip",           -- Snippets
      "saadparwaiz1/cmp_luasnip",   -- Snippet completion
    },
    config = function()
      require("config.lsp-minimal")
    end,
  },

  -- Syntax Highlighting (Essential)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "lua", "json", "yaml", "bash", "dockerfile" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- File Explorer (VSCode-like sidebar)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 35,
          signcolumn = "yes",
        },
        renderer = {
          group_empty = true,
          highlight_git = false,
          highlight_diagnostics = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "⚡",
            info = "⚑",
            warning = "▲",
            error = "✘",
          },
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 400,
        },
      })

      -- Custom nvim-tree highlights for errors only
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticError", { fg = "#F38BA8", bold = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarn", { fg = "#FAB387", bold = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfo", { fg = "#89DCEB" })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHint", { fg = "#A6E3A1" })
    end,
  },

  -- File Icons
  {
    "nvim-tree/nvim-web-devicons",
    config = true,
  },

  -- Status Line (VSCode-like bottom bar)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } }, -- Show relative path
          lualine_x = { "diagnostics", "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Fuzzy Finder (VSCode-like Ctrl+P)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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
      })
    end,
  },

  -- Go Development (Essential for Go)
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimports = 'gopls',
        gofmt = 'gofumpt',
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = true,
        -- Enhanced diagnostics for better error display
        lsp_diag_hdlr = true,
        lsp_diag_underline = true,
        lsp_diag_virtual_text = { space = 0, prefix = " ●" },
        lsp_diag_signs = true,
        lsp_diag_update_in_insert = false,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
  },

  -- Auto-pairs for brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Comment toggle (VSCode-like Ctrl+/)
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  -- Auto Save
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      execution_message = {
        message = function() -- message to print on save
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
      trigger_events = { -- See :h events
        immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
        defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
      },
      -- function that takes the buffer handle and determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if
          fn.getbufvar(buf, "&modifiable") == 1 and
          utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
      write_all_buffers = false, -- write all buffers when the current one meets `condition`
      debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
      callbacks = { -- functions to run at different intervals
        enabling = nil, -- ran when enabling auto-save
        disabling = nil, -- ran when disabling auto-save
        before_asserting_save = nil, -- ran before checking `condition`
        before_saving = nil, -- ran before doing the actual save
        after_saving = nil -- ran after doing the actual save
      }
    },
  },

  -- Terminal (VSCode-like integrated terminal)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]], -- Ctrl+\ to toggle terminal
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 3,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Custom terminal commands
      local Terminal = require('toggleterm.terminal').Terminal

      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      -- Node terminal
      local node = Terminal:new({
        cmd = "node",
        hidden = true,
        direction = "float",
      })

      -- Python terminal
      local python = Terminal:new({
        cmd = "python3",
        hidden = true,
        direction = "float",
      })

      -- Terminal keymaps
      function _lazygit_toggle()
        lazygit:toggle()
      end

      function _node_toggle()
        node:toggle()
      end

      function _python_toggle()
        python:toggle()
      end
    end,
  },
}