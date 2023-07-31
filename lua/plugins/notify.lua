---@type LazyPluginSpec
local P = {
  'rcarriga/nvim-notify',
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = 'Dismiss all Notifications',
    },
  },
  ---@type notify.Config
  opts = {
    fps = 60,
    render = 'compact',
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  },
}

return P
