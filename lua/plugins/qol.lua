-- Quality of Life plugins configuration
local qol_plugins = {
  -- Snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      return require "config.qol.snacks"
    end,
    keys = {
      { "<M-g>", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<M-/>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<M-p>", function() Snacks.explorer() end, desc = "File Explorer" },
    }
  },
  
  -- Trouble integration for Snacks
  {
    "folke/trouble.nvim",
    optional = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return require "config.qol.trouble_snacks"(_, opts)
      end,
    },
  },
  
  -- TreeSJ
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = function()
      return require("config.qol.treesj")
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = function()
      return require("config.qol.surround")
    end,
  },

  -- Hardtime
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = function()
      return require("config.qol.hardtime")
    end,
  },
}

return qol_plugins