---@type LazyPluginSpec
local P = {
  'nvimdev/indentmini.nvim',
  config = function()
    vim.cmd.highlight('IndentLine guifg=#2A2A37')

    vim.cmd.highlight('IndentLineCurrent guifg=#54546D')

    require('indentmini').setup()
  end,
}

return P
