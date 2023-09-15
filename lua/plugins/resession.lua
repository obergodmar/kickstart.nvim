---@type LazyPluginSpec
local P = {
  'stevearc/resession.nvim',
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
      "<cmd>lua require('resession').save()<cr>",
      desc = '[S]ave session',
      id = 'resession_save',
    },
    {
      '<leader>al',
      "<cmd>lua require('resession').load()<cr>",
      desc = '[L]oad session',
      id = 'resession_load',
    },
    {
      '<leader>ad',
      "<cmd>lua require('resession').delete()<cr>",
      desc = '[D]elete session',
      id = 'resession_delete',
    },
  },
}

return P
