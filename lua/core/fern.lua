---@type LazyPluginSpec
local P = {
  -- General purpose asynchronous tree viewer written in Pure Vim script
  'obergodmar/fern.vim',
  dependencies = {
    -- Make fern.vim as a default file explorer instead of Netrw
    'obergodmar/fern-hijack.vim',
    -- Add Git status badge integration on file:// scheme on fern.vim
    'obergodmar/fern-git-status.vim',
    -- An universal palette for Nerd Fonts
    'obergodmar/glyph-palette.vim',
    -- fern.vim plugin which add file type icon through nerdfont.vim
    'obergodmar/fern-renderer-nerdfont.vim',
    -- Fundemental plugin to handle Nerd Fonts in Vim
    'obergodmar/nerdfont.vim',
  },
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.g['fern#renderer'] = 'nerdfont'
    vim.g['nerdfont#autofix_cellwidths'] = 0
  end,
  keys = {
    {
      '<leader>F',
      '<cmd>Fern . -reveal=%<CR>',
      id = 'fern_open',
      desc = 'Fern reveal [F]ile',
    },
  },
}

return P
