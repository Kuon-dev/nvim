-- Utility functions
local M = {}

-- Helper function to safely require modules
M.safe_require = function(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Failed to load module: " .. module .. "\n" .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

return M