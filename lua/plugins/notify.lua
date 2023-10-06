---@type LazyPluginSpec
local P = {
  'rcarriga/nvim-notify',
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss({ silent = true, pending = true })
      end,
      desc = 'Dismiss all Notifications',
      id = 'dismiss_all_notifications',
    },
  },
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
