-- vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.o.shell = "nu"

local autocmd = vim.api.nvim_create_autocmd
-- bootstrap lazy and all plugins

vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "config.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

-- Load options immediately to prevent untitled buffer
require "core.options"

-- InsertLeave autocmd from original config
autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Load other core modules
vim.schedule(function()
  require "core.keymaps"
  require "core.autocmds"
end)

-- Right-click menu handler
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- vim.opt.relativenumber = true
