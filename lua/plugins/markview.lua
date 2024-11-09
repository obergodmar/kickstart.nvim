---@type LazyPluginSpec
local P = {
  'obergodmar/markview.nvim',
  enabled = false,
  ft = 'markdown',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}

return P
