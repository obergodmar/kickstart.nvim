---@type LazyPluginSpec
local P = {
  'mhartington/formatter.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>f',
      ':FormatWrite<CR>',
      id = 'format_file',
      desc = '[F]ormat file',
      mode = 'n',
    },
  },
  config = function()
    local util = require('formatter.util')

    local formatters = {
      lua = {
        require('formatter.filetypes.lua').stylua,
      },
      json = {
        require('formatter.filetypes.json').prettier,
      },
      css = {
        require('formatter.filetypes.css').prettier,
      },
      html = {
        require('formatter.filetypes.html').prettier,
      },
      javascript = {
        require('formatter.filetypes.javascript').prettier,
      },
      javascriptreact = {
        require('formatter.filetypes.javascriptreact').prettier,
      },
      typescript = {
        require('formatter.filetypes.typescript').prettier,
      },
      typescriptreact = {
        require('formatter.filetypes.typescriptreact').prettier,
      },

      php = {
        function()
          return {
            exe = 'phpcbf',
            args = {
              util.escape_path(util.get_current_buffer_file_path()),
            },
            stdin = false,
            ignore_exitcode = true,
          }
        end,
      },
    }

    if vim.fn.has('win32') ~= 1 then
      formatters['*'] = {
        require('formatter.filetypes.any').remove_trailing_whitespace,
      }
    end

    require('formatter').setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = formatters,
    })
  end,
}

return P
