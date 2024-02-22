---@type LazyPluginSpec
local P = {
  -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  'obergodmar/kanagawa.nvim',
  opts = {
    theme = 'wave',
    keywordStyle = { italic = true },
    commentStyle = { italic = true },
  },
  init = function()
    vim.cmd.colorscheme('kanagawa')
  end,
}

return P
