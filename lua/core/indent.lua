---@type LazyPluginSpec
local P = {
  'obergodmar/indent-blankline.nvim',
  event = 'BufReadPost',
  config = function()
    vim.opt.list = true
    require('indent_blankline').setup({
      space_char_blankline = ' ',
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
    })
  end,
}

return P
