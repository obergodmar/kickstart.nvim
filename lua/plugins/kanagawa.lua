---@type LazyPluginSpec
local P = {
  'rebelot/kanagawa.nvim',
  opts = {
    theme = 'wave',
    keywordStyle = { italic = false },
    commentStyle = { italic = true },
  },
  init = function()
    vim.cmd.colorscheme 'kanagawa'
  end,
}

return P
