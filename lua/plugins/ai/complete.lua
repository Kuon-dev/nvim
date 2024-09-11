return {
  {
    "hrsh7th/nvim-cmp",
    opts =  require "plugins.ai.cmp".cmp(),
    config = function()
      require "plugins.ai.cmp".cmp()
    end,
    dependencies = {
      "supermaven-nvim",
      "delphinus/cmp-ctags",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      "ray-x/cmp-treesitter",
      -- {
      --   "tzachar/cmp-tabnine",
      --   build = "powershell ./install.ps1", -- windows only
      --   config = function()
      --     require "plugins.ai.tabnine".tabnine()
      --   end,
      -- },
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
  {
    'Exafunction/codeium.nvim',
    event = { "InsertEnter", "LspAttach" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function ()
      require("codeium").setup({
        enableInComments = false,
      })
    end
  },
}
