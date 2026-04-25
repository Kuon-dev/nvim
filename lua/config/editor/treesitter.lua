-- Treesitter configuration (nvim-treesitter main branch)
-- Highlight and indent are now built into Neovim 0.12+
local parsers = {
  "vim",
  "lua",
  "vimdoc",
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
}

-- Ensure parsers are installed (deferred to let the plugin fully load)
vim.defer_fn(function()
  local installed = require("nvim-treesitter").get_installed()
  local missing = {}
  for _, lang in ipairs(parsers) do
    if not vim.tbl_contains(installed, lang) then
      table.insert(missing, lang)
    end
  end
  if #missing > 0 then
    require("nvim-treesitter").install(missing)
  end
end, 500)
