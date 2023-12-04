---@type LazyPluginSpec
local P = {
  -- An asynchronous linter plugin for Neovim (>= 0.6.0) complementary to the built-in Language Server Protocol support.
  'mfussenegger/nvim-lint',
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

    vim.keymap.set('n', '<leader>l', lint.try_lint, { desc = '[L]int file' })
  end,
}

return P
