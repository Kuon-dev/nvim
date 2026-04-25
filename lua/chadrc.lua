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
     tabufline = {
       enabled = true,
       lazyload = false,
       modules = nil,
     },
  }
}

M.base46 = {
  theme = "chadracula-evondev",
  transparency = true,
  hl_add = {},
  hl_override = {
    -- TbFill = { bg = "statusline_bg" },
    -- TbBufOn = { bg = "dark_purple" },
    -- TbBufOffClose = { bg = "darker_black", fg = "red" },
    -- TbBufOnClose = { bg = "darker_black", fg = "red" },
    -- TbBufOff = { bg = "one_bg3"}
  },
  integrations = {},
  changed_themes = {},
}

return M
