-- Trouble integration for Snacks
return function(_, opts)
  return vim.tbl_deep_extend("force", opts or {}, {
    picker = {
      actions = require("trouble.sources.snacks").actions,
      win = {
        input = {
          keys = {
            ["<M-t>"] = {
              "trouble_open",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
  })
end