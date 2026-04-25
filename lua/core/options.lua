require "nvchad.options"

-- add yours here!

-- Ensure cargo bin is in PATH for tree-sitter CLI etc.
vim.env.PATH = vim.env.HOME .. "/.cargo/bin:" .. vim.env.PATH

local o = vim.o
local set = vim.opt

o.cursorlineopt ='both' -- to enable cursorline!
set.termguicolors = true

local options = {

  smartindent = true,
  smarttab = true,

  backspace = { 'start', 'eol', 'indent' },
  ff = 'unix',

  fileencoding = 'utf-8',
  encoding = 'utf-8',

  foldcolumn = '0',
  foldenable = true,

  shiftwidth = 2,
  autoread = true,
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

set.clipboard:prepend { 'unnamed', 'unnamedplus' }

for i = 1, 9, 1 do
  -- Original Alt+number binding
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
  
  -- Added Right-Shift+number binding using special key code
  vim.keymap.set("n", string.format("<Leader>%s", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)

  vim.keymap.set("n", string.format("<M-Right-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end
