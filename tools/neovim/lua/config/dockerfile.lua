-- Dockerfile Configuration
-- Support for Docker and Docker Compose development

local M = {}

function M.setup()
  -- Dockerfile specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dockerfile", "Dockerfile" },
    callback = function()
      -- Basic Dockerfile settings
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.expandtab = true
      vim.opt_local.textwidth = 0
      vim.opt_local.wrap = false
      
      -- Comments
      vim.opt_local.comments = ":# "
      vim.opt_local.commentstring = "# %s"
      
      -- Folding
      vim.opt_local.foldmethod = "marker"
      vim.opt_local.foldmarker = "#region,#endregion"
      vim.opt_local.foldlevel = 99
      
      -- Dockerfile-specific key mappings
      local opts = { noremap = true, silent = true, buffer = true }
      
      -- Build Docker image
      vim.keymap.set("n", "<leader>db", function()
        local image_name = vim.fn.input("Image name (leave empty for auto): ")
        if image_name == "" then
          image_name = vim.fn.expand("%:p:h:t") .. ":latest"
        end
        vim.cmd(string.format("!docker build -t %s .", image_name))
      end, vim.tbl_extend("force", opts, { desc = "Build Docker image" }))
      
      -- Build with no cache
      vim.keymap.set("n", "<leader>dB", function()
        local image_name = vim.fn.input("Image name (leave empty for auto): ")
        if image_name == "" then
          image_name = vim.fn.expand("%:p:h:t") .. ":latest"
        end
        vim.cmd(string.format("!docker build --no-cache -t %s .", image_name))
      end, vim.tbl_extend("force", opts, { desc = "Build Docker image (no cache)" }))
      
      -- Run Docker container
      vim.keymap.set("n", "<leader>dr", function()
        local image_name = vim.fn.input("Image name: ")
        if image_name ~= "" then
          vim.cmd(string.format("!docker run -it --rm %s", image_name))
        end
      end, vim.tbl_extend("force", opts, { desc = "Run Docker container" }))
      
      -- Lint Dockerfile with hadolint
      vim.keymap.set("n", "<leader>dl", function()
        vim.cmd("!hadolint %")
      end, vim.tbl_extend("force", opts, { desc = "Lint Dockerfile with hadolint" }))
      
      -- Format Dockerfile
      vim.keymap.set("n", "<leader>df", function()
        -- Simple formatting: ensure proper casing for instructions
        vim.cmd([[%s/^\s*\(from\|run\|cmd\|label\|maintainer\|expose\|env\|add\|copy\|entrypoint\|volume\|user\|workdir\|arg\|onbuild\|stopsignal\|healthcheck\|shell\)\s/\U\1 /ge]])
        vim.notify("Dockerfile formatted", vim.log.levels.INFO)
      end, vim.tbl_extend("force", opts, { desc = "Format Dockerfile" }))
      
      -- Docker image inspect
      vim.keymap.set("n", "<leader>di", function()
        local image_name = vim.fn.input("Image name: ")
        if image_name ~= "" then
          vim.cmd(string.format("!docker inspect %s", image_name))
        end
      end, vim.tbl_extend("force", opts, { desc = "Inspect Docker image" }))
      
      -- List Docker images
      vim.keymap.set("n", "<leader>dI", function()
        vim.cmd("!docker images")
      end, vim.tbl_extend("force", opts, { desc = "List Docker images" }))
      
      -- Docker system prune
      vim.keymap.set("n", "<leader>dp", function()
        vim.cmd("!docker system prune -a")
      end, vim.tbl_extend("force", opts, { desc = "Docker system prune" }))
    end,
  })
  
  -- Docker Compose specific settings
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "docker-compose*.yml", "docker-compose*.yaml", "compose*.yml", "compose*.yaml" },
    callback = function()
      vim.bo.filetype = "yaml.docker-compose"
      
      -- Docker Compose specific key mappings
      local opts = { noremap = true, silent = true, buffer = true }
      
      -- Docker Compose up
      vim.keymap.set("n", "<leader>dcu", function()
        vim.cmd("!docker-compose up -d")
      end, vim.tbl_extend("force", opts, { desc = "Docker Compose up" }))
      
      -- Docker Compose down
      vim.keymap.set("n", "<leader>dcd", function()
        vim.cmd("!docker-compose down")
      end, vim.tbl_extend("force", opts, { desc = "Docker Compose down" }))
      
      -- Docker Compose logs
      vim.keymap.set("n", "<leader>dcl", function()
        local service = vim.fn.input("Service name (leave empty for all): ")
        if service == "" then
          vim.cmd("!docker-compose logs -f")
        else
          vim.cmd(string.format("!docker-compose logs -f %s", service))
        end
      end, vim.tbl_extend("force", opts, { desc = "Docker Compose logs" }))
      
      -- Docker Compose restart
      vim.keymap.set("n", "<leader>dcr", function()
        vim.cmd("!docker-compose restart")
      end, vim.tbl_extend("force", opts, { desc = "Docker Compose restart" }))
      
      -- Docker Compose ps
      vim.keymap.set("n", "<leader>dcp", function()
        vim.cmd("!docker-compose ps")
      end, vim.tbl_extend("force", opts, { desc = "Docker Compose ps" }))
      
      -- Docker Compose build
      vim.keymap.set("n", "<leader>dcb", function()
        vim.cmd("!docker-compose build")
      end, vim.tbl_extend("force", opts, { desc = "Docker Compose build" }))
      
      -- Docker Compose exec
      vim.keymap.set("n", "<leader>dce", function()
        local service = vim.fn.input("Service name: ")
        if service ~= "" then
          local command = vim.fn.input("Command (default: /bin/bash): ")
          if command == "" then
            command = "/bin/bash"
          end
          vim.cmd(string.format("!docker-compose exec %s %s", service, command))
        end
      end, vim.tbl_extend("force", opts, { desc = "Docker Compose exec" }))
    end,
  })
  
  -- Auto-detect Dockerfile
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "Dockerfile*", "*.dockerfile" },
    callback = function()
      vim.bo.filetype = "dockerfile"
    end,
  })
end

return M