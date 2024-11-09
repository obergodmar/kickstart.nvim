---@type LazyPluginSpec
local P = {
  'github/copilot.vim',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })

    vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_proxy = '127.0.0.1:12334'
  end,
}

return P
