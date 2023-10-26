---@type LazyPluginSpec
local P = {
  'ray-x/lsp_signature.nvim',
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
