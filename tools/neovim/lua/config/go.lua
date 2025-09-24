-- Go Development Configuration
-- Modern LSP-based configuration for Go development

local M = {}

-- Go-specific settings
function M.setup()
  -- Set up Go filetype-specific options
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
      -- Basic Go settings
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = false
      vim.opt_local.textwidth = 0
      vim.opt_local.wrap = false
      
      -- Go-specific formatting
      vim.opt_local.formatprg = "gofmt"
      vim.opt_local.makeprg = "go build -o /tmp/%:t:r %"
      vim.opt_local.errorformat = "%f:%l:%c:\\ %m"
      
      -- Comments
      vim.opt_local.comments = "s1:/*,mb:*,ex:*/,://"
      vim.opt_local.commentstring = "// %s"
      
      -- Folding
      vim.opt_local.foldmethod = "syntax"
      vim.opt_local.foldlevel = 99
      
      -- Go-specific key mappings
      local opts = { noremap = true, silent = true, buffer = true }
      
      -- Format code
      vim.keymap.set("n", "<leader>gf", function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend("force", opts, { desc = "Format Go code" }))
      
      -- Run go build
      vim.keymap.set("n", "<leader>gb", function()
        vim.cmd("make")
      end, vim.tbl_extend("force", opts, { desc = "Build Go project" }))
      
      -- Run go test
      vim.keymap.set("n", "<leader>gt", function()
        vim.cmd("!go test ./...")
      end, vim.tbl_extend("force", opts, { desc = "Run Go tests" }))
      
      -- Run go test for current file
      vim.keymap.set("n", "<leader>gT", function()
        vim.cmd("!go test " .. vim.fn.expand("%"))
      end, vim.tbl_extend("force", opts, { desc = "Run Go tests for current file" }))
      
      -- Run go run (changed from <leader>gr to avoid conflict with LSP references)
      vim.keymap.set("n", "<leader>gx", function()
        vim.cmd("!go run " .. vim.fn.expand("%"))
      end, vim.tbl_extend("force", opts, { desc = "Run Go program" }))
      
      -- Go to definition
      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
      
      -- Go to references
      vim.keymap.set("n", "gr", function()
        vim.lsp.buf.references()
      end, vim.tbl_extend("force", opts, { desc = "Go to references" }))
      
      -- Hover information
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
      end, vim.tbl_extend("force", opts, { desc = "Show hover information" }))
      
      -- Rename symbol
      vim.keymap.set("n", "<leader>rn", function()
        vim.lsp.buf.rename()
      end, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
      
      -- Code actions
      vim.keymap.set("n", "<leader>ca", function()
        vim.lsp.buf.code_action()
      end, vim.tbl_extend("force", opts, { desc = "Code actions" }))
      
      -- Go imports
      vim.keymap.set("n", "<leader>gi", function()
        vim.cmd("!goimports -w " .. vim.fn.expand("%"))
        vim.cmd("edit")
      end, vim.tbl_extend("force", opts, { desc = "Organize Go imports" }))
      
      -- Go mod tidy
      vim.keymap.set("n", "<leader>gm", function()
        vim.cmd("!go mod tidy")
      end, vim.tbl_extend("force", opts, { desc = "Go mod tidy" }))
      
      -- Go vet
      vim.keymap.set("n", "<leader>gv", function()
        vim.cmd("!go vet ./...")
      end, vim.tbl_extend("force", opts, { desc = "Go vet" }))
      
      -- Go fmt
      vim.keymap.set("n", "<leader>gf", function()
        vim.cmd("!gofmt -w " .. vim.fn.expand("%"))
        vim.cmd("edit")
      end, vim.tbl_extend("force", opts, { desc = "Go fmt" }))
    end,
  })
  
  -- Load Go commands (vim-go replacements)
  require("config.go-commands").setup()
end

return M