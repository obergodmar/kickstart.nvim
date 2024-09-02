---@type LazyPluginSpec
local P = {
  'obergodmar/hover.nvim',
  opts = {
    init = function()
      -- Require providers
      require('hover.providers.lsp')
      -- require('hover.providers.gh')
      -- require('hover.providers.gh_user')
      -- require('hover.providers.jira')
      -- require('hover.providers.dap')
      -- require('hover.providers.fold_preview')
      require('hover.providers.diagnostic')
      require('hover.providers.man')
      require('hover.providers.dictionary')
    end,
    preview_opts = {
      border = 'single',
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = true,
    mouse_providers = {
      'LSP',
      'diagnostic',
      'man',
      'dictionary',
    },
    mouse_delay = 1000,
  },
  keys = {
    {
      '<MouseMove>',
      function()
        require('hover').hover_mouse()
      end,
      id = 'hover mouse',
      desc = 'hover.nvim (mouse)',
      mode = { 'n', 'v' },
    },
    {
      'K',
      function()
        require('hover').hover()
      end,
      id = 'hover',
      desc = 'hover.nvim',
      mode = { 'n' },
    },
    {
      'gK',
      function()
        require('hover').hover_select()
      end,
      id = 'hover select',
      desc = 'hover.nvim (select)',
      mode = { 'n' },
    },
    {
      '<C-p>',
      function()
        require('hover').hover_switch('previous')
      end,
      id = 'hover select previous',
      desc = 'hover.nvim (previous source)',
      mode = { 'n' },
    },
    {
      '<C-n>',
      function()
        require('hover').hover_switch('next')
      end,
      id = 'hover select next',
      desc = 'hover.nvim (next source)',
      mode = { 'n' },
    },
  },
}

return P
