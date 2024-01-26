---@type LazyPluginSpec
local P = {
  -- A fancy, configurable, notification manager for NeoVim
  'obergodmar/nvim-notify',
  ---@type notify.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    fps = 60,
    render = 'compact',
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  },
}

return P
