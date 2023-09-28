---@type LazyPluginSpec
local P = {
  'obergodmar/yanklines.nvim',
  init = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>T', function()
      print('invoked')
      require('yanklines').yank_lines()
    end, { desc = 'Test' })
  end,
}

return P
