---@type LazyPluginSpec
local P = {
  'lambdalisue/fern.vim',
  dependencies = {
    'lambdalisue/fern-hijack.vim',
    'lambdalisue/fern-git-status.vim',
    'lambdalisue/fern-renderer-nerdfont.vim',
    'lambdalisue/nerdfont.vim',
  },
  lazy = false,
  priority = 1000,
  config = function()
    vim.g['fern#renderer'] = 'nerdfont'
  end,
  keys = {
    {
      '<leader>F',
      '<cmd>Fern . -reveal=%<CR>',
      id = 'fern_open',
      desc = 'Fern reveal [F]ile',
    },
  },
}

return P
