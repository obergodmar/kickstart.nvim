---@type LazyPluginSpec
local P = {
  -- An asynchronous linter plugin for Neovim (>= 0.6.0) complementary to the built-in Language Server Protocol support.
  'obergodmar/nvim-lint',
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      lua = { 'luacheck' },

      -- There is ESlint lsp for that
      -- javascript = { 'eslint' },
      -- javascriptreact = { 'eslint' },
      -- typescript = { 'eslint' },
      -- typescriptreact = { 'eslint' },

      -- Stylelint lsp
      -- css = { 'stylelint' },
    }
  end,
  keys = {
    {
      '<leader>l',
      function()
        local lint = require('lint')
        lint.try_lint()
      end,
      id = 'lint_file',
      desc = '[L]int file',
      mode = { 'n', 'v' },
    },
    {
      '<leader>L',
      function()
        vim.diagnostic.reset(nil, 0)
      end,
      id = 'reset_diagnostic',
      desc = '[L]int Reset',
      mode = { 'n', 'v' },
    },
  },
}

return P
