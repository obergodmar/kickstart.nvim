--- @type LazyPluginSpec
local P = {
  'obergodmar/aerial.nvim',
  config = function()
    require('aerial').setup({
      layout = {
        max_width = { 50, 0.3 },
        width = nil,
        min_width = 30,
        placement = 'edge',
      },
      highlight_on_hover = true,
      open_automatic = false,
      on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    })
  end,
  keys = {
    {
      '<leader>a',
      '<cmd>AerialToggle!<CR>',
      id = 'aerial_open',
      desc = '[A]erial Open',
      mode = 'n',
    },
  },
}

return P
