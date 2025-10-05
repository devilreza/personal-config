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

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            "",
            "",
            "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "",
            "",
          },
          center = {
            {
              icon = "  ",
              icon_hl = "Title",
              desc = "Find File           ",
              desc_hl = "String",
              key = "f",
              key_hl = "Number",
              action = "Telescope find_files",
            },
            {
              icon = "  ",
              icon_hl = "Title",
              desc = "Recent Files        ",
              desc_hl = "String",
              key = "r",
              key_hl = "Number",
              action = "Telescope oldfiles",
            },
            {
              icon = "  ",
              icon_hl = "Title",
              desc = "Find Text           ",
              desc_hl = "String",
              key = "g",
              key_hl = "Number",
              action = "Telescope live_grep",
            },
            {
              icon = "  ",
              icon_hl = "Title",
              desc = "File Explorer       ",
              desc_hl = "String",
              key = "e",
              key_hl = "Number",
              action = "NvimTreeToggle",
            },
            {
              icon = "  ",
              icon_hl = "Title",
              desc = "Configuration       ",
              desc_hl = "String",
              key = "c",
              key_hl = "Number",
              action = "edit ~/.config/nvim/init.lua",
            },
            {
              icon = "  ",
              icon_hl = "Title",
              desc = "Quit Neovim         ",
              desc_hl = "String",
              key = "q",
              key_hl = "Number",
              action = "quit",
            },
          },
          footer = {
            "",
            "🚀 Ready to code!",
          },
        },
      })
    end,
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

  -- Blink.cmp (Fast autocompletion)
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      signature = { enabled = true },
    },
  },

  -- LSP Configuration (Essential for error highlighting)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
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
        ensure_installed = { "go", "gomod", "gosum", "lua", "json", "yaml", "bash", "dockerfile" },
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

  -- Buffer/Tab Line (Shows open buffers at the top)
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require("barbar").setup({
        animation = true,
        auto_hide = false,
        tabpages = true,
        clickable = true,
        focus_on_close = "previous",
        hide = { extensions = false, inactive = false },
        highlight_alternate = false,
        highlight_inactive_file_icons = false,
        highlight_visible = true,
        icons = {
          buffer_index = false,
          buffer_number = false,
          button = "",
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "✘" },
            [vim.diagnostic.severity.WARN] = { enabled = true, icon = "▲" },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = false },
          },
          gitsigns = {
            added = { enabled = true, icon = "+" },
            changed = { enabled = true, icon = "~" },
            deleted = { enabled = true, icon = "-" },
          },
          filetype = {
            custom_colors = false,
            enabled = true,
          },
          separator = { left = "▎", right = "" },
          separator_at_end = true,
          modified = { button = "●" },
          pinned = { button = "", filename = true },
          preset = "default",
          alternate = { filetype = { enabled = false } },
          current = { buffer_index = false },
          inactive = { button = "×" },
          visible = { modified = { buffer_number = false } },
        },
        insert_at_end = false,
        insert_at_start = false,
        maximum_padding = 1,
        minimum_padding = 1,
        maximum_length = 30,
        minimum_length = 0,
        semantic_letters = true,
        sidebar_filetypes = {
          NvimTree = true,
          dashboard = { event = "BufWinLeave" },
        },
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
        no_name_title = "[No Name]",
      })

      -- Tab navigation with Shift+Tab only (Tab is used for Codeium in insert mode)
      vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
      vim.keymap.set("n", "<Tab>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })

      -- Additional barbar keymaps
      vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
      vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
      vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true, desc = "Move buffer left" })
      vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true, desc = "Move buffer right" })
      vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "Close buffer" })
      vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", { noremap = true, silent = true, desc = "Pin/unpin buffer" })

      -- Goto buffer in position...
      vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { noremap = true, silent = true, desc = "Goto buffer 1" })
      vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { noremap = true, silent = true, desc = "Goto buffer 2" })
      vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { noremap = true, silent = true, desc = "Goto buffer 3" })
      vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { noremap = true, silent = true, desc = "Goto buffer 4" })
      vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { noremap = true, silent = true, desc = "Goto buffer 5" })
      vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { noremap = true, silent = true, desc = "Goto buffer 6" })
      vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { noremap = true, silent = true, desc = "Goto buffer 7" })
      vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { noremap = true, silent = true, desc = "Goto buffer 8" })
      vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { noremap = true, silent = true, desc = "Goto buffer 9" })
      vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { noremap = true, silent = true, desc = "Goto last buffer" })
    end,
  },

  -- Status Line (VSCode-like bottom bar) with RTL indicator
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Custom RTL status component
      local function rtl_status()
        if vim.wo.rightleft then
          return "RL"
        else
          return "LR"
        end
      end

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
          lualine_x = { rtl_status, "diagnostics", "encoding", "filetype" },
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
        lsp_cfg = {
          root_dir = function(fname)
            local util = require('lspconfig.util')
            return util.root_pattern("go.mod", ".git")(fname)
          end,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
                ST1000 = false,  -- Disable package comment check
              },
              staticcheck = false,  -- Disable staticcheck to avoid ST1000 warnings
              gofumpt = true,
              experimentalPostfixCompletions = true,
            }
          }
        },
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

  -- Git integration with blame support
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 100,
          ignore_whitespace = false,
        },
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      })
    end,
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

  -- Codeium AI completion
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      -- Accept suggestion with Tab
      vim.keymap.set('i', '<Tab>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })

      -- Cycle to next suggestion with Alt+]
      vim.keymap.set('i', '<M-]>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })

      -- Cycle to previous suggestion with Alt+[
      vim.keymap.set('i', '<M-[>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })

      -- Clear suggestion with Alt+c
      vim.keymap.set('i', '<M-c>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })
    end,
  },

}
