---@type LazyPluginSpec
local P = {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  'obergodmar/noice.nvim',
  event = 'VeryLazy',
  ---@type NoiceConfig
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
    cmdline = {
      view = 'cmdline',
    },
  },
  keys = {
    {
      '<leader>snl',
      function()
        require('noice').cmd('last')
      end,
      desc = 'Noice Last Message',
      id = 'last_message',
    },
    {
      '<leader>snh',
      function()
        require('noice').cmd('history')
      end,
      desc = 'Noice History',
      id = 'history',
    },
    {
      '<leader>sna',
      function()
        require('noice').cmd('all')
      end,
      desc = 'Noice All',
      id = 'all',
    },
    {
      '<leader>snd',
      function()
        require('noice').cmd('dismiss')
      end,
      desc = 'Dismiss All',
      id = 'dismiss_all',
    },
    {
      '<c-f>',
      function()
        if not require('noice.lsp').scroll(4) then
          return '<c-f>'
        end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll forward',
      mode = { 'i', 'n', 's' },
      id = 'scroll_forward',
    },
    {
      '<c-b>',
      function()
        if not require('noice.lsp').scroll(-4) then
          return '<c-b>'
        end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll backward',
      mode = { 'i', 'n', 's' },
      id = 'scroll_backward',
    },
  },
}

return P
