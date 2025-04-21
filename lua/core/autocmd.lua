-- Global variables to store the timer and command execution state
vim.g.save_timer = nil
vim.g.command_running = false

-- Function to check for .vectorcode directory in current project
local function check_vectorcode_dir()
  -- Get the current working directory
  local cwd = vim.fn.getcwd()
  local vectorcode_path = cwd .. "/.vectorcode"
  local exists = vim.fn.isdirectory(vectorcode_path) == 1

  if exists then
    vim.api.nvim_echo({{'.vectorcode directory found in project', 'Normal'}}, false, {})
    -- Check if command is already running
    if vim.g.command_running then
      vim.api.nvim_echo({{'Command already running, please wait...', 'WarningMsg'}}, false, {})
      return -- Return false as the command didn't start *now*
    end
    -- Set running flag
    vim.g.command_running = true
    -- Show initial notification that command is starting
    vim.api.nvim_echo({{'Starting vectorcode vectorise command...', 'Normal'}}, false, {})
    -- Run the vectorcode command in a job to not block the editor
    vim.fn.jobstart('vectorcode update', {
      on_stdout = function(_, data)
        if data and #data > 1 then
          vim.schedule(function()
            vim.api.nvim_echo({{'Vectorcode progress: ' .. table.concat(data, '\n'), 'Normal'}}, false, {})
          end)
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 1 then
          vim.schedule(function()
            vim.api.nvim_echo({{'Vectorcode stderr: ' .. table.concat(data, '\n'), 'ErrorMsg'}}, false, {})
          end)
        end
      end,
      on_exit = function(_, exit_code)
        vim.schedule(function()
          -- Clear the running flag
          vim.g.command_running = false -- Ensure this is reset *before* potential subsequent checks
          if exit_code == 0 then
            vim.notify(
              "Vectorcode indexing completed successfully",
              vim.log.levels.INFO,
              { title = "Vectorcode Complete", timeout = 3000 }
            )
          else
            vim.notify(
              "Vectorcode indexing failed with exit code: " .. exit_code,
              vim.log.levels.ERROR,
              { title = "Vectorcode Failed", timeout = 5000 }
            )
          end
        end)
      end
    })
    -- The notification is now handled in the job callbacks
    return true -- Return true as the command was started
  else
    vim.api.nvim_echo({{'.vectorcode directory NOT found in project', 'WarningMsg'}}, false, {})
    return false -- Return false as the directory wasn't found
  end
end

-- Function to handle the debounced execution
local function debounced_check_vectorcode()
  -- If a command is already running, don't schedule a new check.
  -- The current run implicitly covers recent saves.
  if vim.g.command_running then
    vim.api.nvim_echo({{'Debounce: Command already running, skipping new timer scheduling.', 'Comment'}}, false, {})
    return
  end

  -- Clear any existing timer
  if vim.g.save_timer ~= nil then
    vim.fn.timer_stop(vim.g.save_timer)
    vim.g.save_timer = nil
    vim.api.nvim_echo({{'Debounce: Previous timer stopped.', 'Comment'}}, false, {})
  end

  -- Create a new timer
  vim.api.nvim_echo({{'Debounce: Starting new 3000ms timer.', 'Comment'}}, false, {})
  vim.g.save_timer = vim.fn.timer_start(3000, function()
    vim.api.nvim_echo({{'Debounce: Timer fired.', 'Comment'}}, false, {})
    -- Ensure the timer ID is cleared *before* the check,
    -- so a quick save *during* check_vectorcode_dir doesn't see an old timer ID.
    -- However, clearing it *after* makes more sense for the debounce logic itself.
    -- Let's stick to clearing it after the check completes.
    check_vectorcode_dir()
    vim.g.save_timer = nil -- Clear timer ID *after* the check logic runs
  end)
end

-- Create the autocmd
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    debounced_check_vectorcode()
  end,
  desc = "Debounced check for .vectorcode directory on save, run command if found",
})

vim.api.nvim_echo({{'Vectorcode auto-index loaded.', 'Normal'}}, false, {})

-- autocmd("BufWritePre", {
--   group = vim.api.nvim_create_augroup("ts_fix_imports", { clear = true }),
--   desc = "Add missing imports and remove unused imports for TS",
--   pattern = { "*.ts", "*.tsx" },
--   callback = function()
--     local params = vim.lsp.util.make_range_params()
--     params.context = {
--       only = { "source.addMissingImports.ts", "source.removeUnused.ts" },
--     }
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
--     for _, res in pairs(result or {}) do
--       for _, r in pairs(res.result or {}) do
--         if r.kind == "source.addMissingImports.ts" then
--           vim.lsp.buf.code_action({
--             apply = true,
--             context = {
--               only = { "source.addMissingImports.ts" },
--             },
--           })
--           vim.cmd("write")
--         else
--           if r.kind == "source.removeUnused.ts" then
--             vim.lsp.buf.code_action({
--               apply = true,
--               context = {
--                 only = { "source.removeUnused.ts" },
--               },
--             })
--             vim.cmd("write")
--           end
--         end
--       end
--     end
--   end,
-- })
