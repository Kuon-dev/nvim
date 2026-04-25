-- Main plugins configuration
-- This file loads core plugins and imports category modules

return {
  -- Conform (formatter)
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "config.tools.conform"
    end,
  },
  
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "config.lsp.servers"
    end,
  },
  
  -- Mason
  {
    "williamboman/mason.nvim",
    opts = function()
      return require "config.tools.mason"
    end,
  },
  
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
      dofile(vim.g.base46_cache .. "syntax")
      require "config.editor.treesitter"
      vim.treesitter.language.register('markdown', 'mdx')
    end,
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
      "luckasRanarison/tailwind-tools.nvim",
    },
    build = ":TSUpdate",
  },
  
  -- VSCode-style diff viewer
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function()
      return require("config.tools.vscode_diff")
    end,
  },

  -- Disable NvChad defaults replaced by Snacks
  { "nvim-tree/nvim-tree.lua", enabled = false },
  { "nvim-telescope/telescope.nvim", enabled = false },

  -- Import category modules
  { import = "plugins.ui" },
  { import = "plugins.ai" },
  { import = "plugins.qol" },
  { import = "plugins.lsp" },
  { import = "plugins.tools" },
  { import = "plugins.editor" },
}