-- LSP Server Configuration using vim.lsp.config (Neovim 0.11+)
local nvchad_lspconfig = require("nvchad.configs.lspconfig")

-- Servers with default config
local servers = {
  "html",
  "jsonls",
  "cssls",
  "gopls",
  "astro",
  "pyright",
  "clangd",
  "biome",
  "rust_analyzer",
}

-- Enable all servers with default config
vim.lsp.enable(servers)

-- Go: gopls with enhanced settings
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- MDX Analyzer
vim.lsp.config("mdx_analyzer", {
  filetypes = { "mdx" },
})
vim.lsp.enable("mdx_analyzer")

-- Emmet Language Server
vim.lsp.config("emmet_language_server", {
  filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
  init_options = {
    includeLanguages = {},
    excludeLanguages = {},
    extensionsPath = {},
    preferences = {},
    showAbbreviationSuggestions = true,
    showExpandedAbbreviation = "always",
    showSuggestionsAsSnippets = false,
    syntaxProfiles = {},
    variables = {},
  },
})
vim.lsp.enable("emmet_language_server")

-- ESLint with custom diagnostic handler to filter prettier/prettier
vim.lsp.config("eslint", {
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      if result then
        result.diagnostics = vim.tbl_filter(function(diagnostic)
          return diagnostic.code ~= "prettier/prettier"
        end, result.diagnostics or {})
      end
      vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
    end,
  },
})
vim.lsp.enable("eslint")

-- TypeScript Tools (separate plugin, uses its own setup)
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

require("typescript-tools").setup({
  on_attach = nvchad_lspconfig.on_attach,
  capabilities = nvchad_lspconfig.capabilities,
  on_init = nvchad_lspconfig.on_init,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  root_dir = function(fname)
    return vim.fs.root(fname, { ".git" })
  end,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {},
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_file_preferences = {},
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})
