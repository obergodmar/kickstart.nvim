---@type LazyPluginSpec
local P = {
  -- A neovim plugin which just copies text matched by search to the system clipboard
  'obergodmar/yanklines.nvim',
  keys = {
    {
      '<leader>sy',
      '<cmd>lua require("yanklines").yank_lines()<cr>',
      desc = '[Y]ank matched text',
      mode = { 'n' },
      id = 'yanklines',
    },
    {
      '<leader>sy',
      '<cmd>lua require("yanklines").yank_lines(true)<cr>',
      desc = '[Y]ank matched text',
      mode = { 'v' },
      id = 'yanklines_v_block',
    },
  },
}

return P
