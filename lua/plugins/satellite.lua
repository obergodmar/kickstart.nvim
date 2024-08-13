---@diagnostic disable: missing-fields
---@type LazyPluginSpec
local P = {
  'obergodmar/satellite.nvim',
  config = function()
    require('satellite').setup({
      current_only = true,
      handlers = {
        cursor = {
          enable = true,
        },
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
        },
        gitsigns = {
          enable = true,
        },
        marks = {
          enable = true,
        },
      },
    })
  end,
}

return P
