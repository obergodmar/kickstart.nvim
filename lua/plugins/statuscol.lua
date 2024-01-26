---@type LazyPluginSpec
local P = {
  'obergodmar/statuscol.nvim',
  branch = 'master',
  event = 'VeryLazy',
  config = function()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      segments = {
        {
          text = { '%s', builtin.lnumfunc, ' ' },
        },
        {
          text = {
            '%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " ") : " " }',
            ' ',
          },
          hl = 'FoldColumn',
          sign = {
            name = { '.*' },
            fillchar = ' ',
            fillcharhl = nil,
          },
        },
      },
    })
  end,
}

return P
