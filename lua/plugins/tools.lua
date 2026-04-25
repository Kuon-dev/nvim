-- Development tools plugins configuration
return {
  -- TS Comments
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  
  -- Render Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    event = "BufRead",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  },
  
  -- Typr (typing practice)
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
}