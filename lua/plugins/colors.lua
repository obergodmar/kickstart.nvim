---@type LazyPluginSpec
local P = {
  -- A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
  'obergodmar/nvim-colorizer.lua',
  event = 'VeryLazy',
  config = function()
    require('colorizer').setup({ '*' }, {
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
    })
  end,
}

return P
