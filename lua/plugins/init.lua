-- nvim/lua/plugins/init.lua
local nui = require("plugins.ui.nui")
local noice = require("plugins.ui.noice")
local ai = require("plugins.ai.complete")
local agent = require("plugins.ai.goose")
-- local mcp = require("plugins.ai.cmp")
local telescope = require("plugins.ui.telescope")

local ui = {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
    event = "ModeChanged",
    config = function()
      local opt = require "configs.ufo"
      require('ufo').setup(opt.options)
      require('ufo').setFoldVirtTextHandler(opt.bufnr, opt.handler)
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.o.foldlevel = 99
    end
  },
  {
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 5,
      maxkeys = 5,
      show_count = true,
      keyformat = {
        ["<BS>"] = "󰁮 ",
        ["<CR>"] = "󰘌",
        ["<Space>"] = "󱁐",
        ["<Up>"] = "󰁝",
        ["<Down>"] = "󰁅",
        ["<Left>"] = "󰁍",
        ["<Right>"] = "󰁔",
        ["<PageUp>"] = "Page 󰁝",
        ["<PageDown>"] = "Page 󰁅",
        ["<M>"] = "Opt",
        ["<C>"] = "Ctrl",
      },
      -- more opts
    }
  },
  nui,
  noice,
  {
    "tris203/precognition.nvim",
    -- event = "VeryLazy",
    opts = {
    -- startVisible = true,
    -- showBlankVirtLine = true,
    -- highlightColor = { link = "Comment" },
    -- hints = {
    --      Caret = { text = "^", prio = 2 },
    --      Dollar = { text = "$", prio = 1 },
    --      MatchingPair = { text = "%", prio = 5 },
    --      Zero = { text = "0", prio = 1 },
    --      w = { text = "w", prio = 10 },
    --      b = { text = "b", prio = 9 },
    --      e = { text = "e", prio = 8 },
    --      W = { text = "W", prio = 7 },
    --      B = { text = "B", prio = 6 },
    --      E = { text = "E", prio = 5 },
    -- },
    -- gutterHints = {
    --     G = { text = "G", prio = 10 },
    --     gg = { text = "gg", prio = 9 },
    --     PrevParagraph = { text = "{", prio = 8 },
    --     NextParagraph = { text = "}", prio = 8 },
    -- },
    -- disabled_fts = {
    --     "startify",
    -- },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end
  },
}

local lsp = {
  {
    "nvimdev/lspsaga.nvim",
    lazy = false,
    config = function()
        require "configs.lspsaga"
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    }
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  }
}

local qol = {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      -- dashboard = { enabled = false },
      -- explorer = { enabled = true },
      indent = { enabled = true },
      -- input = { enabled = true },
      picker = { enabled = true },
      -- notifier = { enabled = true },
      -- quickfile = { enabled = true },
      -- scope = { enabled = true },
      lazygit = { enabled = true },
      -- scroll = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- words = { enabled = true },
    },
    keys = {
      { "<M-g>", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<M-/>", function() Snacks.picker.smart() end, desc = "Smart Find Files"  },
      { "<M-p>", function() Snacks.explorer() end, desc = "File Explorer" },
    }
  },
  {
    "folke/trouble.nvim",
    optional = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
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
      end,
    },
  },
  {
  'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({--[[ your config ]]})
    end,
  },
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },
  {
     "m4xshen/hardtime.nvim",
     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
     opts = {
      max_time = 100000,
    }
  },
}

local dev = {
  {
    "sindrets/diffview.nvim",
    event = "LspAttach",
  },
  {
    "editorconfig/editorconfig-vim",
    event = "LspAttach",
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    event = "BufRead",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
  {
      "nvzone/typr",
      dependencies = "nvzone/volt",
      opts = {},
      cmd = { "Typr", "TyprStats" },
  },
  {
      "ravitemer/mcphub.nvim",
      dependencies = {
          "nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
      },
      build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
      config = function()
          require("mcphub").setup({
              -- Required options
              port = 3000,  -- Port for MCP Hub server
              config = vim.fn.expand("~/mcpservers.json"),  -- Absolute path to config file

              -- Optional options
              on_ready = function(hub)
                  -- Called when hub is ready
              end,
              on_error = function(err)
                  -- Called on errors
              end,
              shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
              log = {
                  level = vim.log.levels.WARN,
                  to_file = false,
                  file_path = nil,
                  prefix = "MCPHub"
              },
          })
      end
  }
}

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
  	},
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx"
      },
  	},
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
      -- tell treesitter to use the markdown parser for mdx files
      vim.treesitter.language.register('markdown', 'mdx')
    end,
    dependencies = {
      {
        "nushell/tree-sitter-nu",
      },
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
      "luckasRanarison/tailwind-tools.nvim",
    },
    build = ":TSUpdate",
  },
  ui,
  ai,
  qol,
  lsp,
  dev,
  agent,
}
