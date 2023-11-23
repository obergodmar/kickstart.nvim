---@type LazyPluginSpec
local P = {
  'ray-x/lsp_signature.nvim',
  commit = '9ed85616b772a07f8db56c26e8fff2d962f1f211',
  event = 'VeryLazy',
  opts = {
    bind = false,
    noice = true,
    floating_window = true,
    hint_prefix = '',
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}

return P
