-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
-- test
local M = {}

M.ui = {
  cmp = {
    lspkind_text = true,
    format_colors = {
      tailwind = true
    },
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  }
}

M.base46 = {
  theme = "chadracula-evondev",
  transparency = true,
}

return M
