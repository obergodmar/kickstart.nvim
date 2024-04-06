---@type LazyPluginSpec
local P = {
  'obergodmar/rest.nvim',
  branch = 'v1.2.1',
  ft = 'http',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  config = function()
    require('rest-nvim').setup()
  end,
  keys = {
    {
      '<leader>r',
      function()
        require('rest-nvim').run()
      end,
      id = 'rest-nvim_run',
      desc = '[R]un rest-nvim request',
    },
    {
      '<leader>R',
      function()
        require('rest-nvim').last()
      end,
      id = 'rest-nvim_run',
      desc = '[R]un Last rest-nvim request',
    },
  },
}

return P
