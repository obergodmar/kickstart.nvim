---@type LazyPluginSpec
local P = {
  'obergodmar/multiple-cursors.nvim',
  opts = {},
  keys = {
    { '<C-j>', '<Cmd>MultipleCursorsAddDown<CR>', mode = { 'n', 'x' }, desc = 'Add cursor and move down' },
    { '<C-k>', '<Cmd>MultipleCursorsAddUp<CR>', mode = { 'n', 'x' }, desc = 'Add cursor and move up' },

    { '<C-M-Up>', '<Cmd>MultipleCursorsAddUp<CR>', mode = { 'n', 'i', 'x' }, desc = 'Add cursor and move up' },
    { '<C-M-Down>', '<Cmd>MultipleCursorsAddDown<CR>', mode = { 'n', 'i', 'x' }, desc = 'Add cursor and move down' },

    { '<C-LeftMouse>', '<Cmd>MultipleCursorsMouseAddDelete<CR>', mode = { 'n', 'i' }, desc = 'Add or remove cursor' },

    { '<Leader>w', '<Cmd>MultipleCursorsAddMatches<CR>', mode = { 'n', 'x' }, desc = 'Add cursors to cword' },
    {
      '<Leader>W',
      '<Cmd>MultipleCursorsAddMatchesV<CR>',
      mode = { 'n', 'x' },
      desc = 'Add cursors to cword in previous area',
    },

    {
      '<Leader>d',
      '<Cmd>MultipleCursorsAddJumpNextMatch<CR>',
      mode = { 'n', 'x' },
      desc = 'Add cursor and jump to next cword',
    },
    { '<Leader>D', '<Cmd>MultipleCursorsJumpNextMatch<CR>', mode = { 'n', 'x' }, desc = 'Jump to next cword' },

    { '<Leader>m', '<Cmd>MultipleCursorsLock<CR>', mode = { 'n', 'x' }, desc = 'Lock virtual cursors' },

    {
      'n',
      '<Leader>|',
      function()
        require('multiple-cursors').align()
      end,
    },
    pre_hook = function()
      require('cmp').setup({ enabled = false })
    end,
    post_hook = function()
      require('cmp').setup({ enabled = true })
    end,
  },
}

return P
