-- Spell checking configuration
-- Replaces spellsitter.nvim for Neovim 0.11.x compatibility

local M = {}

function M.setup()
  -- Set default spell language
  vim.opt.spelllang = { 'en_us' }
  
  -- Enable spell checking for specific file types
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit", "rst", "org" },
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.spellcapcheck = ""  -- Don't check for capital letters at start of sentences
    end,
  })
  
  -- Spell check keymaps (only active when spell is enabled)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit", "rst", "org" },
    callback = function()
      local opts = { buffer = true, silent = true }
      -- ]s - Next misspelled word
      -- [s - Previous misspelled word
      -- z= - Show spelling suggestions
      -- zg - Add word to dictionary
      -- zw - Mark word as wrong
      vim.keymap.set("n", "<leader>ss", function()
        vim.opt_local.spell = not vim.opt_local.spell:get()
        if vim.opt_local.spell:get() then
          print("Spell checking enabled")
        else
          print("Spell checking disabled")
        end
      end, { desc = "Toggle spell checking", buffer = true })
    end,
  })
  
  -- Customize spell highlighting
  vim.api.nvim_set_hl(0, "SpellBad", { sp = "#ff0000", undercurl = true })
  vim.api.nvim_set_hl(0, "SpellCap", { sp = "#ffaa00", undercurl = true })
  vim.api.nvim_set_hl(0, "SpellRare", { sp = "#00aaff", undercurl = true })
  vim.api.nvim_set_hl(0, "SpellLocal", { sp = "#00ff00", undercurl = true })
end

return M