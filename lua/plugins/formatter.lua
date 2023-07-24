return {
  "mhartington/formatter.nvim",
  config = function()
    local util = require("formatter.util")

    require("formatter").setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        lua = {
          require("formatter.filetypes.lua").stylua,

          function()
            if util.get_current_buffer_file_name() == "special.lua" then
              return nil
            end

            return {
              exe = "stylua",
              args = {
                "--search-parent-directories",
                "--stdin-filepath",
                util.escape_path(util.get_current_buffer_file_path()),
                "--",
                "-",
              },
              stdin = true,
            }
          end,
        },

        json = {
          require("formatter.filetypes.json").prettierd,
        },
        css = {
          require("formatter.filetypes.css").prettierd,
        },
        html = {
          require("formatter.filetypes.html").prettierd,
        },
        javascript = {
          require("formatter.filetypes.javascript").eslint_d,
          require("formatter.filetypes.javascript").prettierd,
        },
        javascriptreact = {
          require("formatter.filetypes.javascriptreact").eslint_d,
          require("formatter.filetypes.javascriptreact").prettierd,
        },
        typescript = {
          require("formatter.filetypes.typescript").eslint_d,
          require("formatter.filetypes.typescript").prettierd,
        },
        typescriptreact = {
          require("formatter.filetypes.typescriptreact").eslint_d,
          require("formatter.filetypes.typescriptreact").prettierd,
        },

        php = {
          function()
            return {
              exe = "phpcbf",
              args = {
                util.escape_path(util.get_current_buffer_file_path()),
              },
              stdin = false,
              ignore_exitcode = true,
            }
          end,
        },

        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    })

    vim.keymap.set("n", "<leader>f", ":FormatWrite<CR>", { desc = "[F]ormat file" })
  end,
}
