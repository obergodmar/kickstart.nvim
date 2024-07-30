---@type LazyPluginSpec
local P = {
  -- Nvim Treesitter configurations and abstraction layer
  'obergodmar/nvim-treesitter',
  commit = '74dc34a7fa8e1ea4bcc4578f7a4b14e3ec8c189f',
  dependencies = {
    {
      'obergodmar/nvim-treesitter-context',
      opts = {
        multiline_threshold = 1,
        mode = 'topline',
      },
    },
    {
      'obergodmar/treesitter-indent-object.nvim',
      keys = {
        {
          'ai',
          function()
            require('treesitter_indent_object.textobj').select_indent_outer()
          end,
          mode = { 'x', 'o' },
          desc = 'Select context-aware indent (outer)',
        },
        {
          'aI',
          function()
            require('treesitter_indent_object.textobj').select_indent_outer(true)
          end,
          mode = { 'x', 'o' },
          desc = 'Select context-aware indent (outer, line-wise)',
        },
        {
          'ii',
          function()
            require('treesitter_indent_object.textobj').select_indent_inner()
          end,
          mode = { 'x', 'o' },
          desc = 'Select context-aware indent (inner, partial range)',
        },
        {
          'iI',
          function()
            require('treesitter_indent_object.textobj').select_indent_inner(true, 'V')
          end,
          mode = { 'x', 'o' },
          desc = 'Select context-aware indent (inner, entire range) in line-wise visual mode',
        },
      },
    },
    'obergodmar/nvim-treesitter-textobjects',
    'obergodmar/nvim-treesitter-refactor',
  },
  config = function()
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))

    require('nvim-treesitter.configs').setup({
      additional_vim_regex_highlighting = false,
      modules = {},
      ignore_install = {},
      sync_install = true,
      ensure_installed = {
        'markdown',
        'markdown_inline',
        'regex',
        'lua',
        'vim',
        'bash',
        'comment',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        lsp_interop = {
          enable = false,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = { query = '@class.outer', desc = 'Next class start' },

            [']o'] = '@loop.*',

            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          goto_next = {
            [']e'] = '@conditional.outer',
          },
          goto_previous = {
            ['[e'] = '@conditional.outer',
          },
        },
      },
      refactor = {
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = true,
        },
        highlight_current_scope = {
          enable = false,
        },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = 'grr',
          },
        },
        navigation = {
          enable = true,
          keymaps = {
            goto_definition_lsp_fallback = 'gd',
          },
        },
      },
    })
  end,
}

return P
