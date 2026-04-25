-- UI plugins configuration
local nui_plugins = require("plugins.ui.nui")
local noice_plugins = require("plugins.ui.noice")

-- Merge all UI plugins
local ui_plugins = {
  -- Base46 theme
  { "nvchad/base46", branch = "v3.0" },
  
  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
    event = "ModeChanged",
    config = function()
      local opt = require "config.ui.ufo"
      require('ufo').setup(opt.options)
      require('ufo').setFoldVirtTextHandler(opt.bufnr, opt.handler)
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.o.foldlevel = 99
    end
  },
  
  -- Showkeys
  {
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    opts = function()
      return require "config.ui.showkeys"
    end
  },
  
  -- Precognition
  {
    "tris203/precognition.nvim",
    -- event = "VeryLazy",
    opts = function()
      return require("config.ui.precognition")
    end,
  },
  
}

-- Merge plugins from nui.lua and noice.lua
for _, plugin in ipairs(nui_plugins) do
  table.insert(ui_plugins, plugin)
end

for _, plugin in ipairs(noice_plugins) do
  table.insert(ui_plugins, plugin)
end

return ui_plugins