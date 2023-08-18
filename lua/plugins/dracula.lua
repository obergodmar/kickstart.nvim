---@type LazyPluginSpec
local P = {
  'Mofiqul/dracula.nvim',
  enabled = false,
  opts = {
    show_end_of_buffer = true,
    italic_comment = true,
    lualine_bg_color = '#44475a',
  },
  init = function()
    vim.cmd.colorscheme 'dracula'
  end,
}

return P
