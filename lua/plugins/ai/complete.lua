return {
  {
    "hrsh7th/nvim-cmp",
    opts =  require "plugins.ai.cmp".cmp(),
    config = function()
      require "plugins.ai.cmp".cmp()
    end,
    dependencies = {
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
    event = { "InsertEnter", "LspAttach" },
    config = function()
      require("supermaven-nvim").setup({
        disable_inline_completion = true, -- Disable inline completion for use with cmp
        disable_keymaps = true
      })
    end,
  },
  {
      'milanglacier/minuet-ai.nvim',
      config = function ()
        require "plugins.ai.minuet".minuet()
      end,
  },
  -- {
  --   'Exafunction/codeium.nvim',
  --   event = { "InsertEnter", "LspAttach" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function ()
  --     require("codeium").setup({
  --       enableInComments = false,
  --     })
  --   end
  -- },
}
