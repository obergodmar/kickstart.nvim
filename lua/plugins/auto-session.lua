local P = {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
    { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
  },

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    cwd_change_handling = true,
    -- log_level = 'debug',
  },
}

return P
