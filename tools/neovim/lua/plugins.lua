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

  -- THEME MANAGER & COLORSCHEMES
  {
    "andrew-george/telescope-themes",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("themes")
    end,
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "shaunsingh/nord.nvim", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "sainnhe/everforest", priority = 1000 },
  { "navarasu/onedark.nvim", priority = 1000 },

  -- Monokai Pro Theme
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        transparent_background = false,
        terminal_colors = true,
        devicons = true,
        styles = {
          comment = { italic = true },
          keyword = { italic = true },
          function_ = { italic = true },
          variable = {},
        },
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
        -- Enable this will disable filter option
        day_night = {
          enable = false,
          day_filter = "pro",
          night_filter = "spectrum",
        },
        inc_search = "background", -- underline | background
        background_clear = {
          -- "float_win",
          "toggleterm",
          "telescope",
          -- "which-key",
          "renamer",
          "notify",
          -- "nvim-tree",
          -- "neo-tree",
          -- "bufferline"
        },
        plugins = {
          bufferline = {
            underline_selected = false,
            underline_visible = false,
          },
          indent_blankline = {
            context_highlight = "default", -- default | pro
            context_start_underline = false,
          },
        },
        override = function(c)
          return {}
        end,
        ---@param cs Colorscheme
        on_highlights = function(cs, colors)
          return {}
        end,
      })
      vim.cmd.colorscheme("monokai-pro")
    end,
  },

  -- Minuet AI (LiteLLM / OpenAI-compatible inline autocomplete)
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("minuet").setup({
        provider = "openai_compatible",
        request_timeout = 4,
        throttle = 1000,
        notify = "warn",
        provider_options = {
          openai_compatible = {
            model = "claude-sonnet-4-6",
            end_point = (vim.env.OPENAI_API_BASE or "https://litellm.phini.dev/v1") .. "/chat/completions",
            api_key = "OPENAI_API_KEY",
            stream = true,
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })

      vim.g.minuet_enabled = true

      local function toggle_minuet()
        vim.g.minuet_enabled = not vim.g.minuet_enabled
        local state = vim.g.minuet_enabled and "enabled" or "disabled"
        vim.notify("Minuet AI autocomplete " .. state, vim.log.levels.INFO)
      end

      vim.api.nvim_create_user_command("ToggleMinuet", toggle_minuet, { desc = "Toggle Minuet AI autocomplete" })
      vim.api.nvim_create_user_command("MinuetToggle", toggle_minuet, { desc = "Toggle Minuet AI autocomplete" })
      vim.api.nvim_create_user_command("ToggelMinuet", toggle_minuet, { desc = "Toggle Minuet AI autocomplete (typo alias)" })
    end,
  },

  -- Blink.cmp (Fast autocompletion)
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Exafunction/windsurf.nvim", -- Load windsurf before blink.cmp tries to use it
      "milanglacier/minuet-ai.nvim",
    },
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
        default = { "lsp", "path", "snippets", "buffer", "codeium", "minuet" },
        providers = {
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            async = true,
            enabled = function()
              -- Only enable if codeium is available and initialized
              local ok, codeium = pcall(require, "codeium")
              if not ok then
                return false
              end
              -- Check if server is initialized and enabled
              -- Be more lenient - if server exists, allow it (it might be starting)
              if codeium.s == nil then
                return false
              end
              -- Return true if server exists (enabled check might be nil during startup)
              return codeium.s.enabled ~= false
            end,
          },
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            score_offset = 8,
            enabled = function()
              return vim.g.minuet_enabled ~= false
            end,
          },
        },
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
        ensure_installed = {
          "go", "gomod", "gosum",
          "rust", "toml", "ron",
          "typescript", "tsx", "javascript", "jsdoc",
          "html", "css", "scss",
          "lua", "json", "yaml", "bash", "dockerfile",
        },
        highlight = { enable = true },
        indent = { enable = true },
        fold = { 
          enable = true, -- Enable treesitter-based folding
        },
      })
      
      -- Setup folding method for buffers with treesitter support
      -- This ensures folding works even if treesitter doesn't auto-set it
      vim.api.nvim_create_autocmd({ "BufReadPost", "FileType" }, {
        group = vim.api.nvim_create_augroup("treesitter_fold_setup", { clear = true }),
        callback = function()
          -- Skip for certain file types
          local ft = vim.bo.filetype
          if ft == "" or ft == "help" or ft == "man" or ft == "qf" or ft == "terminal" then
            return
          end
          
          -- Set foldmethod to expr with treesitter foldexpr
          -- This works when treesitter fold is enabled
          vim.opt_local.foldmethod = "expr"
          vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
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
          theme = "monokai-pro",
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
        lsp_on_attach = function(client, bufnr)
          -- Use the global on_attach function from lsp-minimal.lua
          if _G.lsp_on_attach then
            _G.lsp_on_attach(client, bufnr)
          else
            -- Fallback: set up keybindings directly
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', bufopts, { desc = 'Go to definition' }))
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.declaration, vim.tbl_extend('force', bufopts, { desc = 'Go to declaration' }))
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', bufopts, { desc = 'Go to implementation' }))
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, vim.tbl_extend('force', bufopts, { desc = 'Go to type definition' }))
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', bufopts, { desc = 'Find references' }))
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', bufopts, { desc = 'Show documentation' }))
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, vim.tbl_extend('force', bufopts, { desc = 'Rename symbol' }))
          end
        end,
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

  -- Rust Development (rustaceanvim manages rust-analyzer LSP, DAP, runnables)
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false, -- this plugin is already lazy
    ft = { "rust" },
    init = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.g.rustaceanvim = {
        server = {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            if _G.lsp_on_attach then
              _G.lsp_on_attach(client, bufnr)
            end
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              checkOnSave = true,
              check = { command = "clippy", extraArgs = { "--no-deps" } },
              procMacro = { enable = true },
              inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = "never" },
                lifetimeElisionHints = { enable = "never", useParameterNames = false },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = "never" },
                renderColons = true,
                typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
              },
            },
          },
        },
        tools = {
          float_win_config = { border = "rounded" },
        },
      }
    end,
  },

  -- Cargo.toml dependency UI (versions, updates, features)
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        completion = {
          crates = { enabled = true },
          cmp = { enabled = false },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },

  -- React/JSX: auto-close and auto-rename HTML/JSX/TSX tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },

  -- Formatter (prettier for JS/TS/JSON/CSS/HTML/MD; stylua for Lua)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
      },
    },
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
        current_line_blame = true,
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

  -- Git Fugitive (Powerful Git wrapper)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gstatus", "Gwrite", "Gread", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gsplit", "Gvsplit", "Gtabedit", "Gtabdiffsplit", "Gtabvdiffsplit", "Gmove", "Gdelete", "Gremove", "Ggrep", "Glgrep", "Glog", "Gllog", "Gbrowse", "Gblame", "Gdiff", "Gmerge", "Gpull", "Gpush", "Gfetch", "Gclog", "Gcommit", "Gadd", "Greset", "Gstash", "Gtag", "Gbranch", "Gcheckout", "Grebase", "Gsubmodule" },
    config = function()
      -- vim-fugitive doesn't need much configuration
      -- It works out of the box with standard Git commands
      -- Note: Commands with hyphens like cherry-pick should be called as :Git cherry-pick
    end,
  },

  -- Terminal (VSCode-like integrated terminal)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = nil, -- Disable default mapping, use keymaps.lua instead
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
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

      -- Main floating terminal (default terminal for Ctrl+`)
      local float_term = Terminal:new({
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 3,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
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

      function _float_term_toggle()
        float_term:toggle()
      end
    end,
  },

  -- Windsurf AI completion
  -- Repository: https://github.com/Exafunction/windsurf.nvim
  -- Note: Uses 'codeium' module name internally
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy", -- Load early to ensure codeium.blink is available
    priority = 1000, -- High priority to load before blink.cmp
    config = function()
      require("codeium").setup({
        -- Tab to accept completion (handled by blink.cmp)
        -- Authentication: Run :Codeium Auth in Neovim
        enable_cmp_source = false, -- Disable nvim-cmp source since we're using blink.cmp
        -- Virtual text: Show inline suggestions like Copilot/Cursor
        virtual_text = {
          enabled = true, -- Enable inline suggestions
          filetypes = {}, -- Empty means enable for all filetypes
          default_filetype_enabled = true, -- Enable by default for all filetypes
          manual = false, -- Auto-trigger suggestions (set to true to only show on manual trigger)
          idle_delay = 75, -- Wait 75ms after typing stops before showing suggestions
          virtual_text_priority = 65535, -- High priority to show above other virtual text
          map_keys = false, -- Disable automatic key mapping (we handle Tab manually in keymaps.lua)
          accept_fallback = "<C-t>", -- Fallback to indent when no suggestion (handled in keymaps.lua)
          key_bindings = {
            accept = "<Tab>", -- Accept suggestion with Tab (handled manually)
            accept_word = false, -- Set to keybinding to accept only next word
            accept_line = false, -- Set to keybinding to accept only next line
            clear = false, -- Set to keybinding to clear suggestion
            next = "<M-]>", -- Cycle to next suggestion (Alt+])
            prev = "<M-[>", -- Cycle to previous suggestion (Alt+[)
          },
        },
      })
      
      -- Debug: Check if codeium is working
      vim.api.nvim_create_user_command("CodeiumStatus", function()
        local ok, codeium = pcall(require, "codeium")
        if not ok then
          vim.notify("Codeium module not found", vim.log.levels.ERROR)
          return
        end
        
        if codeium.s == nil then
          vim.notify("Codeium server not initialized", vim.log.levels.WARN)
          return
        end
        
        local status = codeium.s.enabled and "enabled" or "disabled"
        vim.notify("Codeium status: " .. status, vim.log.levels.INFO)
      end, { desc = "Check Codeium status" })
    end,
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_port = ''
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_filetypes = {'markdown'}
      vim.g.mkdp_theme = 'dark'

      -- Keymaps for markdown preview
      vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Toggle Markdown Preview' })
    end,
  },

}
