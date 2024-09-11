local defaults = require("nvchad.configs.cmp")
local luasnip = require("luasnip")
local M = {}

-- Function to check if there are words before the cursor
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local cmp = require "cmp"
-- local supermaven = require("supermaven-nvim.completion_preview")

M.cmp = function()
  local options = {
    formatting = {
      -- You can customize the formatting here if needed
    },
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
      autocomplete = false, -- Disable automatic completion
      keyword_length = 2,
    },
    experimental = {
      ghost_text = false -- Disable ghost text as Supermaven will handle this
    },
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   if supermaven.has_suggestion() then
      --     supermaven.on_accept_suggestion()
      --   elseif cmp.visible() then
      --     cmp.select_next_item()
      --   elseif luasnip.expand_or_locally_jumpable() then
      --     luasnip.expand_or_jump()
      --   elseif has_words_before() then
      --     cmp.complete()
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      -- ["<ESC>"] = cmp.mapping(function(fallback)
      --   if supermaven.has_suggestion() then
      --     supermaven.on_clear_suggestion()
      --     cmp.complete() -- Trigger cmp after clearing Supermaven suggestion
      --   elseif cmp.visible() then
      --     cmp.abort()
      --   else
      --     fallback()
      --   end
      -- end, {
      --   "i",
      --   "s",
      -- }),
    },
    performance = {
      debounce = 150,
      throttle = 60,
      fetching_timeout = 200,
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "supermaven" },
      { name = "luasnip" },
      { name = "nvim_lsp",
        max_item_count = 30,
        entry_filter = function(entry, ctx)
          return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
        end,
      },
      { name = "nvim_lua" },
      { name = "tailwind" },
      { name = "path" },
    },
    matching = {
      disallow_fuzzy_matching = true,
      disallow_fullfuzzy_matching = true,
      disallow_partial_fuzzy_matching = true,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = true,
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  }
  cmp.setup(vim.tbl_deep_extend("force", defaults, options))
end

-- Set up Supermaven
-- require("supermaven-nvim").setup({
--   disable_inline_completion = true, -- Disable inline completion for use with cmp
--   condition = function()
--     -- Only run Supermaven when entering insert mode from normal mode
--     return vim.api.nvim_get_mode().mode ~= "n"
--   end
-- })

-- Set up an autocommand to restart Supermaven when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if vim.api.nvim_get_mode().mode == "i" then
      require("supermaven-nvim.api").restart()
    end
  end,
})

return M
