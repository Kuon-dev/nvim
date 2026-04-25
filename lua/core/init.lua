-- Core module entry point
-- Load all core modules in the correct order

require "core.options"    -- Vim options first
require "core.autocmds"   -- Auto commands
require "core.keymaps"    -- Key mappings