-- Noice plugin (uses Snacks.notifier instead of nvim-notify)
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function()
      return require("config.ui.noice")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
