---@type LazyPluginSpec
local P = {
  -- Useful plugin to show you pending keybinds.
  'obergodmar/which-key.nvim',
  event = 'VeryLazy',
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
