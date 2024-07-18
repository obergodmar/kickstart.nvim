---@type LazyPluginSpec
local P = {
  -- improve neovim lsp experience
  'obergodmar/lspsaga.nvim',
  event = 'VeryLazy',
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
    code_action = {
      show_server_name = true,
      extend_gitsigns = true,
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
      'cr',
      '<cmd>Lspsaga rename<CR>',
      id = 'lspsaga_rename',
      desc = '[R]e[n]ame',
      mode = 'n',
    },
    {
      'cR',
      '<cmd>Lspsaga rename ++project<CR>',
      id = 'lspsaga_rename_all',
      desc = '[R]e[n]ame Everywhere',
      mode = 'n',
    },
    -- {
    --   'K',
    --   '<cmd>Lspsaga hover_doc<CR>',
    --   id = 'lspsaga_hover_doc',
    --   desc = 'Hover documentation',
    --   mode = 'n',
    -- },
    {
      '<leader>e',
      '<cmd>Lspsaga show_line_diagnostics<CR>',
      id = 'lspsaga_show_line_diagnostics',
      desc = 'Open floating diagnostic message (current line)',
      mode = 'n',
    },
    {
      '[d',
      '<cmd>Lspsaga diagnostic_jump_prev<CR>',
      id = 'lspsaga_diagnostic_jump_prev',
      desc = 'Go to previous diagnostic message',
      mode = 'n',
    },
    {
      ']d',
      '<cmd>Lspsaga diagnostic_jump_next<CR>',
      id = 'lspsaga_diagnostic_jump_next',
      desc = 'Go to next diagnostic message',
      mode = 'n',
    },
    {
      'ga',
      '<cmd>Lspsaga finder ref+def+imp<CR>',
      id = 'lspsaga_finder_ref_def_imp',
      desc = '[G]oto [A]ll',
      mode = 'n',
    },
  },
}

return P
