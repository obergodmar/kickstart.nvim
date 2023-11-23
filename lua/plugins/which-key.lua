-- Useful plugin to show you pending keybinds.
---@type LazyPluginSpec
local P = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  enabled = false,
  opts = {
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
  },
}

return P
