---@type LazyPluginSpec
local P = {
  -- Smooth scrolling neovim plugin written in lua
  'obergodmar/neoscroll.nvim',
  enabled = function()
    return not vim.g.neovide
  end,
  opts = {
    hide_cursor = false,
    easing_function = [[sine]],
    performance_mode = false,
    pre_hook = function()
      vim.opt.eventignore:append({
        'WinScrolled',
        'CursorMoved',
      })
    end,
    post_hook = function()
      vim.opt.eventignore:remove({
        'WinScrolled',
        'CursorMoved',
      })
    end,
  },
}

return P
