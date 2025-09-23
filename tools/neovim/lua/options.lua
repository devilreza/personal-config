-- Neovim Options Configuration
-- Modern settings optimized for Go development

local opt = vim.opt
local g = vim.g

-- General settings
opt.mouse = "a"                    -- Enable mouse support
opt.clipboard = "unnamedplus"      -- Use system clipboard
opt.swapfile = false               -- Disable swap files
opt.backup = false                 -- Disable backup files
opt.undofile = true                -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Display settings
opt.number = true                  -- Show line numbers
opt.relativenumber = true          -- Show relative line numbers
opt.cursorline = true              -- Highlight current line
opt.signcolumn = "yes"             -- Always show sign column
opt.wrap = false                   -- Don't wrap lines
opt.scrolloff = 8                  -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8              -- Keep 8 columns left/right of cursor
opt.showmode = false               -- Don't show mode in status line
opt.showcmd = true                 -- Show command in status line
opt.cmdheight = 1                  -- Command line height
opt.laststatus = 3                 -- Global status line
opt.showtabline = 2                -- Show tab line
opt.pumheight = 10                 -- Popup menu height
opt.pumwidth = 30                  -- Popup menu width

-- Search settings
opt.ignorecase = true              -- Ignore case in search
opt.smartcase = true               -- Smart case sensitivity
opt.hlsearch = true                -- Highlight search results
opt.incsearch = true               -- Incremental search
opt.wrapscan = true                -- Wrap search around file

-- Indentation settings
opt.autoindent = true              -- Auto indent
opt.smartindent = true             -- Smart indent
opt.expandtab = true               -- Use spaces instead of tabs
opt.tabstop = 4                    -- Tab width
opt.shiftwidth = 4                 -- Indent width
opt.softtabstop = 4                -- Soft tab width
opt.shiftround = true              -- Round indent to shiftwidth

-- Performance settings
opt.lazyredraw = true              -- Lazy redraw
opt.updatetime = 300               -- Update time
opt.timeoutlen = 500               -- Timeout length
opt.ttimeoutlen = 10               -- Key code timeout

-- File settings
opt.encoding = "utf-8"             -- File encoding
opt.fileencoding = "utf-8"         -- File encoding
opt.fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936"

-- Completion settings
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")          -- Don't show completion messages

-- Wildmenu settings
opt.wildmenu = true                -- Enable wildmenu
opt.wildmode = "longest:full,full" -- Wildmenu mode
opt.wildignore = {
  "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
  "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/*",
  "*/node_modules/*", "*.so", "*.swp", "*.zip", "*.tar.gz"
}

-- Folding settings
opt.foldmethod = "expr"            -- Folding method
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99                 -- Fold level
opt.foldlevelstart = 99            -- Start fold level
opt.foldenable = true              -- Enable folding

-- Go-specific settings
opt.formatprg = "gofmt"            -- Go formatter
opt.makeprg = "go build -o /tmp/%:t:r %"  -- Go make program
opt.errorformat = "%f:%l:%c:\\ %m"  -- Go error format

-- Global variables
-- Note: mapleader and maplocalleader are set in init.lua before Lazy loads
g.loaded_netrw = 1                 -- Disable netrw
g.loaded_netrwPlugin = 1           -- Disable netrw plugin
g.loaded_netrwSettings = 1         -- Disable netrw settings
g.loaded_netrwFileHandlers = 1     -- Disable netrw file handlers

-- Go development specific
g.go_doc_keywordprg_enabled = 0    -- Disable go doc keyword program
g.go_auto_type_info = 1            -- Auto type info
g.go_auto_sameids = 1              -- Auto same ids
g.go_highlight_functions = 1       -- Highlight functions
g.go_highlight_methods = 1         -- Highlight methods
g.go_highlight_structs = 1         -- Highlight structs
g.go_highlight_interfaces = 1      -- Highlight interfaces
g.go_highlight_operators = 1       -- Highlight operators
g.go_highlight_build_constraints = 1 -- Highlight build constraints
g.go_highlight_generate_tags = 1   -- Highlight generate tags
g.go_highlight_extra_types = 1     -- Highlight extra types
g.go_highlight_space_tab_error = 0 -- Don't highlight space tab error
g.go_highlight_array_whitespace_error = 0 -- Don't highlight array whitespace error
g.go_highlight_chan_whitespace_error = 0 -- Don't highlight chan whitespace error
g.go_highlight_trailing_whitespace_error = 0 -- Don't highlight trailing whitespace error
g.go_highlight_extra_types = 1     -- Highlight extra types
g.go_highlight_space_tab_error = 0 -- Don't highlight space tab error
g.go_highlight_array_whitespace_error = 0 -- Don't highlight array whitespace error
g.go_highlight_chan_whitespace_error = 0 -- Don't highlight chan whitespace error
g.go_highlight_trailing_whitespace_error = 0 -- Don't highlight trailing whitespace error
