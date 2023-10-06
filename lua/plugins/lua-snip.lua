---@type LazyPluginSpec
local P = {
  'L3MON4D3/LuaSnip',
  build = (not jit.os:find('Windows'))
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
    or nil,
  dependencies = {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  opts = {
    history = true,
    delete_check_events = 'TextChanged',
  },
  keys = {
    {
      '<tab>',
      function()
        return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
      end,
      expr = true,
      silent = true,
      mode = 'i',
      id = 'snippet',
    },
    {
      '<tab>',
      function()
        require('luasnip').jump(1)
      end,
      mode = 's',
      id = 'snippet_next',
    },
    {
      '<s-tab>',
      function()
        require('luasnip').jump(-1)
      end,
      mode = { 'i', 's' },
      id = 'snippet_prev',
    },
  },
}

return P
