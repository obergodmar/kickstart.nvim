---@type LazyPluginSpec
local P = {
  -- Status column plugin that provides a configurable 'statuscolumn' and click handlers. Requires Neovim >= 0.9.
  'luukvbaal/statuscol.nvim',
  branch = vim.fn.has('nvim-0.10') == 1 and '0.10' or 'main',
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
