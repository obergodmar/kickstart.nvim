return {
  'glepnir/lspsaga.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = '[C]ode [A]ction' })
    vim.keymap.set('n', 'rn', '<cmd>Lspsaga rename<CR>', { desc = '[R]e[n]ame' })
    vim.keymap.set('n', 'rN', '<cmd>Lspsaga rename ++project<CR>', { desc = '[R]e[n]ame Everywhere' })
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'Hover documentation' })

    require('lspsaga').setup {
      lightbulb = {
        enable = false,
      },
      ui = {
        devicon = true,
      },
      symbol_in_winbar = {
        respect_root = true,
      },
    }
  end,
}
