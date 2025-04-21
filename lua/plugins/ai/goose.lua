return {
  {
    'azorng/goose.nvim',
    event = "LspAttach",
    branch = 'main',
    config = function()
      require('goose').setup({})
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
        },
      }
    },
  }
}
