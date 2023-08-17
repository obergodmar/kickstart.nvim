---@type LazyPluginSpec
local P = {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
  },
  opts = {
    ---@type bufferline.Options
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
