---@type LazyPluginSpec
local P = {
  -- Status column plugin that provides a configurable 'statuscolumn' and click handlers. Requires Neovim >= 0.9.
  'luukvbaal/statuscol.nvim',
  event = 'VeryLazy',
  config = function()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      relculright = true,
      segments = {
        { text = { '%s' }, click = 'v:lua.ScSa' },
        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
        { text = { ' ', builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
      },
    })
  end,
}

return P
