-- LSP plugins configuration
return {
  -- LSP Saga
  {
    "nvimdev/lspsaga.nvim",
    lazy = false,
    config = function()
      require "config.lsp.lspsaga"
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter"
    }
  },
  
  -- TypeScript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  }
}