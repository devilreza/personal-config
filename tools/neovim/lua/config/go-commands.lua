-- Go Commands and Navigation for Neovim
-- Using LSP (gopls) instead of vim-go

local M = {}

function M.setup()
  -- Create user commands that work like the old vim-go commands
  
  -- Navigation commands
  vim.api.nvim_create_user_command("GoDef", function()
    vim.lsp.buf.definition()
  end, { desc = "Go to definition" })
  
  vim.api.nvim_create_user_command("GoRefs", function()
    vim.lsp.buf.references()
  end, { desc = "Find references" })
  
  vim.api.nvim_create_user_command("GoImpl", function()
    vim.lsp.buf.implementation()
  end, { desc = "Go to implementation" })
  
  vim.api.nvim_create_user_command("GoDecl", function()
    vim.lsp.buf.declaration()
  end, { desc = "Go to declaration" })
  
  vim.api.nvim_create_user_command("GoType", function()
    vim.lsp.buf.type_definition()
  end, { desc = "Go to type definition" })
  
  -- Code modification commands
  vim.api.nvim_create_user_command("GoRename", function()
    vim.lsp.buf.rename()
  end, { desc = "Rename symbol" })
  
  vim.api.nvim_create_user_command("GoFmt", function()
    vim.lsp.buf.format({ async = false })
  end, { desc = "Format code" })
  
  vim.api.nvim_create_user_command("GoImports", function()
    -- Organize imports using LSP code action
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end, { desc = "Organize imports" })
  
  -- Build and run commands
  vim.api.nvim_create_user_command("GoBuild", function(opts)
    local cmd = "go build"
    if opts.args ~= "" then
      cmd = cmd .. " " .. opts.args
    else
      cmd = cmd .. " " .. vim.fn.expand("%:p:h")
    end
    vim.cmd("!" .. cmd)
  end, { nargs = "*", desc = "Build Go package" })
  
  vim.api.nvim_create_user_command("GoRun", function(opts)
    local cmd = "go run"
    if opts.args ~= "" then
      cmd = cmd .. " " .. opts.args
    else
      cmd = cmd .. " " .. vim.fn.expand("%")
    end
    vim.cmd("!" .. cmd)
  end, { nargs = "*", desc = "Run Go file" })
  
  vim.api.nvim_create_user_command("GoTest", function(opts)
    local cmd = "go test"
    if opts.args ~= "" then
      cmd = cmd .. " " .. opts.args
    else
      cmd = cmd .. " " .. vim.fn.expand("%:p:h")
    end
    cmd = cmd .. " -v"
    vim.cmd("!" .. cmd)
  end, { nargs = "*", desc = "Run Go tests" })
  
  vim.api.nvim_create_user_command("GoTestFunc", function()
    local test_func = vim.fn.search("^func Test", "bcnW")
    if test_func == 0 then
      vim.notify("No test function found", vim.log.levels.WARN)
      return
    end
    local line = vim.fn.getline(test_func)
    local test_name = line:match("func (Test%w+)")
    if test_name then
      vim.cmd(string.format("!go test %s -run ^%s$ -v", vim.fn.expand("%:p:h"), test_name))
    end
  end, { desc = "Run test function at cursor" })
  
  vim.api.nvim_create_user_command("GoCoverage", function()
    vim.cmd("!go test -cover " .. vim.fn.expand("%:p:h"))
  end, { desc = "Run tests with coverage" })
  
  vim.api.nvim_create_user_command("GoVet", function(opts)
    local cmd = "go vet"
    if opts.args ~= "" then
      cmd = cmd .. " " .. opts.args
    else
      cmd = cmd .. " " .. vim.fn.expand("%:p:h")
    end
    vim.cmd("!" .. cmd)
  end, { nargs = "*", desc = "Run go vet" })
  
  vim.api.nvim_create_user_command("GoLint", function()
    local file = vim.fn.expand("%")
    if vim.fn.executable("golangci-lint") == 1 then
      vim.cmd("!golangci-lint run " .. file)
    else
      vim.notify("golangci-lint not found. Install with: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest", vim.log.levels.ERROR)
    end
  end, { desc = "Run golangci-lint" })
  
  -- Module commands
  vim.api.nvim_create_user_command("GoModTidy", function()
    vim.cmd("!go mod tidy")
  end, { desc = "Run go mod tidy" })
  
  vim.api.nvim_create_user_command("GoModDownload", function()
    vim.cmd("!go mod download")
  end, { desc = "Run go mod download" })
  
  -- Install commands
  vim.api.nvim_create_user_command("GoInstall", function(opts)
    local cmd = "go install"
    if opts.args ~= "" then
      cmd = cmd .. " " .. opts.args
    else
      cmd = cmd .. " ."
    end
    vim.cmd("!" .. cmd)
  end, { nargs = "*", desc = "Run go install" })
  
  -- Better error handling for Go
  vim.api.nvim_create_user_command("GoErrCheck", function()
    if vim.fn.executable("errcheck") == 1 then
      vim.cmd("!errcheck " .. vim.fn.expand("%:p:h"))
    else
      vim.notify("errcheck not found. Install with: go install github.com/kisielk/errcheck@latest", vim.log.levels.ERROR)
    end
  end, { desc = "Run errcheck" })
  
  -- Add format on save for Go files
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      -- Save cursor position
      local cursor = vim.api.nvim_win_get_cursor(0)
      
      -- Organize imports
      local params = vim.lsp.util.make_range_params()
      params.context = {only = {"source.organizeImports"}}
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
            vim.lsp.util.apply_workspace_edit(r.edit, enc)
          end
        end
      end
      
      -- Format
      vim.lsp.buf.format({ async = false })
      
      -- Restore cursor position
      vim.api.nvim_win_set_cursor(0, cursor)
    end,
  })
  
  -- Debugging helpers (if delve is installed)
  vim.api.nvim_create_user_command("GoDebug", function()
    if vim.fn.executable("dlv") == 1 then
      vim.cmd("!dlv debug " .. vim.fn.expand("%:p:h"))
    else
      vim.notify("Delve not found. Install with: go install github.com/go-delve/delve/cmd/dlv@latest", vim.log.levels.ERROR)
    end
  end, { desc = "Start Delve debugger" })
  
  vim.api.nvim_create_user_command("GoDebugTest", function()
    local test_func = vim.fn.search("^func Test", "bcnW")
    if test_func == 0 then
      vim.notify("No test function found", vim.log.levels.WARN)
      return
    end
    local line = vim.fn.getline(test_func)
    local test_name = line:match("func (Test%w+)")
    if test_name and vim.fn.executable("dlv") == 1 then
      vim.cmd(string.format("!dlv test %s -- -test.run ^%s$", vim.fn.expand("%:p:h"), test_name))
    end
  end, { desc = "Debug test at cursor" })
end

return M