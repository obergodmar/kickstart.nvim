---@type LazyPluginSpec
local P = {
  -- A replacement for mksession with a better API
  'obergodmar/resession.nvim',
  opts = {
    autosave = {
      enabled = true,
      interval = 60,
      notify = false,
    },
  },
  keys = {
    {
      '<leader>as',
      function()
        require('resession').save()
      end,
      desc = '[S]ave session',
      id = 'resession_save',
    },
    {
      '<leader>al',
      function()
        require('resession').load()
      end,
      desc = '[L]oad session',
      id = 'resession_load',
    },
    {
      '<leader>ad',
      function()
        require('resession').delete()
      end,
      desc = '[D]elete session',
      id = 'resession_delete',
    },
  },
}

return P
