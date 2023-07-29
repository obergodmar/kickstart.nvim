---@type LazyPluginSpec
local P = {
  'nvim-pack/nvim-spectre',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {},
  keys = {
    {
      '<leader>S',
      '<cmd>lua require("spectre").open()<CR>',
      id = 'spectre_open',
      desc = 'Open',
      mode = 'n',
    },
    {
      '<leader>sw',
      '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
      id = 'spectre_search_current',
      desc = '[S]earch current [W]ord',
      mode = 'n',
    },
    {
      '<leader>sw',
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      id = 'spectre_search_current_visual',
      desc = '[S]earch current [W]ord',
      mode = 'v',
    },
    {
      '<leader>sp',
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      id = 'spectre_search_in_current_file',
      desc = '[S]earch in current file',
      mode = 'n',
    },
  },
}

return P
