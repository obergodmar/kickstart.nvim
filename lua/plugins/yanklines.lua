---@type LazyPluginSpec
local P = {
  'obergodmar/yanklines.nvim',
  keys = {
    {
      '<leader>Y',
      '<cmd>lua require("yanklines").yank_lines()<cr>',
      mode = { 'n', 'v' },
      id = 'yanklines',
    },
  },
}

return P
