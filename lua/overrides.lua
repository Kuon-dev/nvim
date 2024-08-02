local map = vim.keymap.set

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

map({ "n", "t" }, "<M-p>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "serpl",
    cmd = "serpl",
    float_opts = {
      -- height = 0.4,
      relative = "editor",
      row = 0.02,
      -- col = 0.1,
      col = 0.1,
      width = 1,
      height = 0.9,
      border = "single",
    },
  }
end, { desc = "Terminal Toggle Floating term" })

map({ "n", "t" }, "<M-g>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "nuterm",
    cmd = 'lazygit',
    float_opts = {
      -- height = 0.4,
      relative = "editor",
      row = 0.02,
      -- col = 0.1,
      col = 0.1,
      width = 0.8,
      height = 0.9,
      border = "single",
    },
  }
end, { desc = "Terminal Toggle Floating term" })

