local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- For JavaScript/TypeScript files
    javascript = { "biome" },
    typescript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    -- You can also specify multiple formatters
    -- typescript = { "biome", "prettier" }, -- will try biome first, then prettier
  },
  -- If you want format on save
  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
