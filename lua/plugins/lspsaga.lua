---@type LazyPluginSpec
local P = {
  'glepnir/lspsaga.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    lightbulb = {
      enable = false,
    },
    ui = {
      devicon = true,
    },
    symbol_in_winbar = {
      respect_root = true,
    },
  },
  keys = {
    {
      '<leader>ca',
      '<cmd>Lspsaga code_action<CR>',
      id = 'lspsaga_code_action',
      desc = '[C]ode [A]ction',
      mode = { 'n', 'v' },
    },
    {
      'rn',
      '<cmd>Lspsaga rename<CR>',
      id = 'lspsaga_rename',
      desc = '[R]e[n]ame',
      mode = 'n',
    },
    {
      'rN',
      '<cmd>Lspsaga rename ++project<CR>',
      id = 'lspsaga_rename_all',
      desc = '[R]e[n]ame Everywhere',
      mode = 'n',
    },
    {
      'K',
      '<cmd>Lspsaga hover_doc<CR>',
      id = 'lspsaga_hover_doc',
      desc = 'Hover documentation',
      mode = 'n',
    },
  },
}

return P
