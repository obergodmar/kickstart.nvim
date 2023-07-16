return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      text = { "vale" },
      json = { "jsonlint" },
      markdown = { "vale" },
      dockerfile = { "hadolint" },

      lua = { "luacheck" },

      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },

      php = { "phpstan", "phpcs" },
    }

    vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
