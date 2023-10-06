---@type LazyPluginSpec
local P = {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  opts = {
    ---@type bufferline.Options
    ---@diagnostic disable-next-line: missing-fields
    options = {
      mode = 'tabs',
      numbers = 'both',
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      show_close_icon = false,
    },
  },
}

return P
