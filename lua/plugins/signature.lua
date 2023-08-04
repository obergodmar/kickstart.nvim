---@type LazyPluginSpec
local P = {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {
    bind = false,
    floating_window = false,
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}

return P
