-- AI completion configurations
-- This file contains configurations for AI-powered completion plugins

local M = {}

-- Supermaven configuration
M.supermaven = function()
  require("supermaven-nvim").setup({
    disable_inline_completion = true, -- Disable inline completion for use with cmp
    disable_keymaps = true
  })
end

-- Codeium configuration (currently disabled)
M.codeium = function()
  require("codeium").setup({
    enableInComments = false,
  })
end

return M