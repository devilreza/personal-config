-- Auto-save configuration for Neovim
-- Automatically saves files on various triggers

local M = {}

-- Configuration options
local config = {
  enabled = true,
  execution_message = {
    message = function() -- message to print on save
      return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
    end,
    dim = 0.18, -- dim the message
    cleaning_interval = 1250, -- (milliseconds) automatically clean notifications after this time
  },
  trigger_events = {"InsertLeave", "TextChanged"}, -- vim events that trigger auto-save
  condition = function(buf)
    local fn = vim.fn
    local utils = require("config.autosave.utils")

    if
      fn.getbufvar(buf, "&modifiable") == 1 and
      utils.not_in(fn.getbufvar(buf, "&filetype"), {
        "harpoon",
        "neo-tree",
        "NvimTree",
        "TelescopePrompt",
        "lazy",
        "mason",
        "oil",
        "dashboard",
        "alpha",
        "starter",
      }) then
      return true -- met condition(s), can save
    end
    return false -- can't save
  end,
  write_all_buffers = false, -- save all buffers when triggering auto-save
  debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
  callbacks = { -- functions to be executed at different intervals
    enabling = nil, -- ran when enabling auto-save
    disabling = nil, -- ran when disabling auto-save
    before_asserting_save = nil, -- ran before checking `condition`
    before_saving = nil, -- ran before doing the actual save
    after_saving = nil, -- ran after doing the actual save
  }
}

-- Utility functions
local utils = {}

function utils.not_in(value, table_of_values)
  for _, v in ipairs(table_of_values) do
    if v == value then
      return false
    end
  end
  return true
end

-- Save the utils in a separate module-like structure
_G.AutoSaveUtils = utils

-- Auto-save implementation
local autosave_enabled = config.enabled
local timer = vim.loop.new_timer()
local queued_save = false

local function notify(msg)
  if config.execution_message and config.execution_message.message then
    local message = type(config.execution_message.message) == "function" 
      and config.execution_message.message() 
      or config.execution_message.message
    
    vim.notify(message, vim.log.levels.INFO, { title = "AutoSave" })
    
    -- Clear notification after specified interval
    if config.execution_message.cleaning_interval then
      vim.defer_fn(function()
        vim.cmd("echon ''")
      end, config.execution_message.cleaning_interval)
    end
  end
end

local function save_buffer(buf)
  if config.callbacks.before_saving then
    config.callbacks.before_saving()
  end
  
  if config.write_all_buffers then
    vim.cmd("silent! wall")
  else
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! write")
    end)
  end
  
  if config.callbacks.after_saving then
    config.callbacks.after_saving()
  end
  
  notify()
end

local function should_save(buf)
  if config.callbacks.before_asserting_save then
    config.callbacks.before_asserting_save()
  end
  
  if config.condition then
    return config.condition(buf)
  end
  
  return true
end

local function debounced_save(buf)
  if not autosave_enabled then
    return
  end
  
  if not should_save(buf) then
    return
  end
  
  queued_save = true
  
  timer:stop()
  timer:start(config.debounce_delay, 0, vim.schedule_wrap(function()
    if queued_save and autosave_enabled and should_save(buf) then
      save_buffer(buf)
      queued_save = false
    end
  end))
end

function M.setup(opts)
  -- Merge user options with defaults
  if opts then
    config = vim.tbl_deep_extend("force", config, opts)
  end
  
  -- Create utils module for condition function
  package.loaded["config.autosave.utils"] = utils
  
  -- Set up autocmds
  local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
  
  for _, event in ipairs(config.trigger_events) do
    vim.api.nvim_create_autocmd(event, {
      group = autosave_group,
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        debounced_save(buf)
      end,
    })
  end
  
  -- Add FocusLost event for saving when leaving Neovim
  vim.api.nvim_create_autocmd("FocusLost", {
    group = autosave_group,
    callback = function()
      if autosave_enabled then
        vim.cmd("silent! wall")
      end
    end,
  })
  
  -- Commands to toggle auto-save
  vim.api.nvim_create_user_command("AutoSaveToggle", function()
    M.toggle()
  end, {})
  
  vim.api.nvim_create_user_command("AutoSaveEnable", function()
    M.enable()
  end, {})
  
  vim.api.nvim_create_user_command("AutoSaveDisable", function()
    M.disable()
  end, {})
  
  -- Keymaps
  vim.keymap.set("n", "<leader>as", function() M.toggle() end, { desc = "Toggle auto-save" })
  
  if config.callbacks.enabling and autosave_enabled then
    config.callbacks.enabling()
  end
end

function M.toggle()
  if autosave_enabled then
    M.disable()
  else
    M.enable()
  end
end

function M.enable()
  if not autosave_enabled then
    autosave_enabled = true
    vim.notify("AutoSave enabled", vim.log.levels.INFO)
    if config.callbacks.enabling then
      config.callbacks.enabling()
    end
  end
end

function M.disable()
  if autosave_enabled then
    autosave_enabled = false
    timer:stop()
    queued_save = false
    vim.notify("AutoSave disabled", vim.log.levels.INFO)
    if config.callbacks.disabling then
      config.callbacks.disabling()
    end
  end
end

function M.is_enabled()
  return autosave_enabled
end

return M