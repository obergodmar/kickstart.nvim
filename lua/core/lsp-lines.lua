---@type LazyPluginSpec
local P = {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = 'LspAttach',
  config = function()
    require('lsp_lines').setup()
  end,
  keys = {
    {
      '<Leader>l',
      function()
        ---@diagnostic disable-next-line: undefined-field
        if vim.diagnostic.config().virtual_lines == true then
          vim.diagnostic.config({
            virtual_lines = {
              only_current_line = true,
              highlight_whole_line = true,
            },
          })
        else
          vim.diagnostic.config({
            virtual_lines = true,
          })
        end
      end,
      id = 'lsp_lines_toggle',
      desc = 'Toggle lsp_lines',
    },
  },
}

return P
