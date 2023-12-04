---@type LazyPluginSpec
local P = {
  -- A neovim plugin which just copies text matched by search to the system clipboard
  'obergodmar/yanklines.nvim',
  keys = {
    {
      '<leader>Y',
      '<cmd>lua require("yanklines").yank_lines()<cr>',
      mode = { 'n' },
      id = 'yanklines',
    },
    {
      '<leader>Y',
      '<cmd>lua require("yanklines").yank_lines(true)<cr>',
      mode = { 'v' },
      id = 'yanklines_v_block',
    },
  },
}

return P
