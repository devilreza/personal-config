-- gRPC and Protocol Buffers Configuration
-- Support for .proto files and gRPC development

local M = {}

function M.setup()
  -- Protocol Buffers filetype specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "proto" },
    callback = function()
      -- Basic Proto settings
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.expandtab = true
      vim.opt_local.textwidth = 80
      vim.opt_local.wrap = false
      
      -- Comments
      vim.opt_local.comments = "s1:/*,mb:*,ex:*/,://"
      vim.opt_local.commentstring = "// %s"
      
      -- Folding
      vim.opt_local.foldmethod = "syntax"
      vim.opt_local.foldlevel = 99
      
      -- Proto-specific key mappings
      local opts = { noremap = true, silent = true, buffer = true }
      
      -- Format proto file using buf or clang-format
      vim.keymap.set("n", "<leader>pf", function()
        -- Try buf format first, fallback to clang-format
        local buf_exists = vim.fn.executable("buf") == 1
        if buf_exists then
          vim.cmd("!buf format -w %")
        else
          vim.cmd("!clang-format -i %")
        end
        vim.cmd("edit")
      end, vim.tbl_extend("force", opts, { desc = "Format proto file" }))
      
      -- Lint proto file using buf
      vim.keymap.set("n", "<leader>pl", function()
        vim.cmd("!buf lint %")
      end, vim.tbl_extend("force", opts, { desc = "Lint proto file" }))
      
      -- Generate code from proto
      vim.keymap.set("n", "<leader>pg", function()
        vim.cmd("!buf generate")
      end, vim.tbl_extend("force", opts, { desc = "Generate code from proto" }))
      
      -- Breaking change detection
      vim.keymap.set("n", "<leader>pb", function()
        vim.cmd("!buf breaking --against .git#branch=main")
      end, vim.tbl_extend("force", opts, { desc = "Check breaking changes" }))
    end,
  })
  
  -- gRPC-specific Go settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
      local opts = { noremap = true, silent = true, buffer = true }
      
      -- Generate gRPC mock
      vim.keymap.set("n", "<leader>ggm", function()
        local file_path = vim.fn.expand("%:p")
        if file_path:match("%.pb%.go$") then
          vim.notify("This is a generated file, use the .proto file instead", vim.log.levels.WARN)
          return
        end
        
        -- Generate mock for current interface
        local interface_name = vim.fn.input("Interface name: ")
        if interface_name ~= "" then
          vim.cmd(string.format("!mockgen -source=%s -destination=mocks/%s_mock.go -package=mocks %s", 
            vim.fn.expand("%"), vim.fn.expand("%:t:r"), interface_name))
        end
      end, vim.tbl_extend("force", opts, { desc = "Generate gRPC mock" }))
      
      -- Run gRPC test with specific flags
      vim.keymap.set("n", "<leader>ggt", function()
        vim.cmd("!go test -v -tags=integration ./...")
      end, vim.tbl_extend("force", opts, { desc = "Run gRPC integration tests" }))
    end,
  })
end

return M