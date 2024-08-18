---@type LazyPluginSpec
local P = {
  'obergodmar/diffview.nvim',
  config = function()
    require('diffview').setup()

    vim.api.nvim_set_keymap('n', '<leader>hD', '<cmd>DiffviewOpen<CR>', { desc = '[Diffview] Open' })
  end,
}

return P
