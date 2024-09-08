local nui = require("plugins.ui.nui")
local noice = require("plugins.ui.noice")
local ai = require("plugins.ai.complete")
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
  nui,
  noice,
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      }
    end
  },
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
    event = "LspAttach",
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
    "editorconfig/editorconfig-vim",
    event = "LspAttach",
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {} -- your configuration
  },
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
        "tsx",
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
}
