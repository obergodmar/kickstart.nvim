return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require 'lint'

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
