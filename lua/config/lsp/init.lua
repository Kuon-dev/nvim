-- LSP module entry point
-- Coordinates LSP setup and configuration

return {
  -- Export commonly used configurations
  servers = require("config.lsp.servers"),
  lspsaga = require("config.lsp.lspsaga"),
}