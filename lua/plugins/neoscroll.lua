---@type LazyPluginSpec
local P = {
  'karb94/neoscroll.nvim',
  enabled = function()
    return not vim.g.neovide
  end,
  opts = {},
}

return P
