---@type LazyPluginSpec
local P = {
  -- A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
  'norcalli/nvim-colorizer.lua',
  event = 'VeryLazy',
  opts = { '*' },
}

return P
