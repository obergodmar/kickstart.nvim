---@type LazyPluginSpec
local P = {
  -- Highlight, list and search todo comments in your projects
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- All the lua functions I don't want to write twice.
    'nvim-lua/plenary.nvim',
  },
  opts = {},
}

return P
