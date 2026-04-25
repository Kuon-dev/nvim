-- AI and completion plugins configuration
return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.completion.cmp").cmp()
    end,
    dependencies = {
      "delphinus/cmp-ctags",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      "ray-x/cmp-treesitter",
    },
  },
}
