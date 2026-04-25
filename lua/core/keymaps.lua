require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", ";f", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", ";a", function() Snacks.picker.files({ hidden = true, ignored = true, follow = true }) end, { desc = "Find All Files" })
map("n", ";r", function() Snacks.picker.grep() end, { desc = "Live Grep" })
map("n", ";b", function() Snacks.picker.buffers() end, { desc = "Find Buffers" })
map("n", ";h", function() Snacks.picker.help() end, { desc = "Help Page" })
map("n", ";o", function() Snacks.picker.recent() end, { desc = "Find Old Files" })
map("n", ";k", function() Snacks.picker.keymaps() end, { desc = "Show Keys" })

map('n', '<C-m>', '<cmd>:%s/\r//g<CR>', { desc = 'Set file endings to unix (LF)' })
map('n', 'x', '"_x', { desc = 'Delete without yank'})
map('n', '<Leader>i', 'ci"', { desc = 'Replace strings' })
map('n', '<Leader>ri', '<cmd>TSToolsAddMissingImports<cr>', { desc = 'Add missing imports' })
map('n', '<Leader>rx', '<cmd>TSToolsRemoveUnused<cr>', { desc = 'Remove unused imports' })

-- Trouble mappings
-- Trouble mappings
map('n', '<Leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle Trouble diagnostics' })
map('n', '<Leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Toggle Trouble buffer diagnostics' })
map('n', '<Leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Toggle Trouble symbols' })
map('n', '<Leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'Toggle Trouble LSP' })
map('n', '<Leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Toggle Trouble location list' })
map('n', '<Leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Toggle Trouble quickfix list' })

-- Undo mappings
map('n', '<C-z>', 'u', { desc = 'Undo' })
map('i', '<C-z>', 'u', { desc = 'Undo' })
map('v', '<C-z>', 'u', { desc = 'Undo' })

-- markdown nvim
map('n', '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', { desc = 'Markdown Preview' })
map('n', '<leader>tp', '<cmd>ShowkeysToggle<CR>', { desc = 'Markdown Preview' })
map('n', '<leader>tt', function() require("menu").open("default") end, { desc = "Open Menu" })
map('n', '<leader>tx', function() require("menu").close() end, { desc = "Close Menu" })

-- Explorer and LSP mappings
map('n', '<C-p>', function() Snacks.explorer() end, { desc = 'File Explorer' })
map('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { desc = "LSP Saga Finder" })
map('n', '<Leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = "Code Action" })
map('n', 'gr', '<cmd>Lspsaga rename<CR>', { desc = "Rename All Occurrences" })
map('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { desc = "Peek Definition" })
map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', { desc = "Go to Definition" })
map('n', 'gt', '<cmd>Lspsaga peek_type_definition<CR>', { desc = "Peek Type Definition" })
map('n', '<Leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>', { desc = "Show Line Diagnostics" })
map('n', '<Leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>', { desc = "Show Buffer Diagnostics" })
map('n', '<Leader>sw', '<cmd>Lspsaga show_workspace_diagnostics<CR>', { desc = "Show Workspace Diagnostics" })
map('n', '<Leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { desc = "Show Cursor Diagnostics" })
map('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = "Diagnostic Jump Previous" })
map('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = "Diagnostic Jump Next" })
map('n', ';p', function() require("nvim-navbuddy").open() end, { desc = "Toggle NavBuddy" })

-- Flash mappings
map('n', '<leader>S', '<cmd>require("flash").treesitter()<CR>', { desc = "Flash Treesitter" })
map('n', '<leader>r', '<cmd>require("flash").remote()<CR>', { desc = "Remote Flash" })
map('n', '<leader>R', '<cmd>require("flash").treesitter_search()<CR>', { desc = "Treesitter Search" })
map('n', '<leader>s', '<cmd>require("flash").toggle()<CR>', { desc = "Toggle Flash Search" })

map({ "n", "t" }, "<M-l>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "nuterm",
    cmd = 'nu',
    float_opts = {
      -- height = 0.4,
      relative = "editor",
      row = 0.05,
      -- col = 0.05,
      -- col = ,
      -- width = 0.9,
      height = 0.8,
      border = "single",
    },
  }
end, { desc = "Terminal Toggle Floating term" })


-- map({ "n", "t" }, "<M-p>", function()
--   require("nvchad.term").toggle {
--     pos = "float",
--     id = "serpl",
--     cmd = "serpl",
--     float_opts = {
--       -- height = 0.4,
--       relative = "editor",
--       row = 0.02,
--       -- col = 0.1,
--       col = 0.1,
--       width = 1,
--       height = 0.9,
--       border = "single",
--     },
--   }
-- end, { desc = "Terminal Toggle Floating term" })
