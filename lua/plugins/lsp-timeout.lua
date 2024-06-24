---@type LazyPluginSpec
local P = {
  'obergodmar/lsp-timeout.nvim',
  init = function()
    vim.g.lspTimeoutConfig = {
      stopTimeout = 1000 * 60 * 30, -- ms, timeout before stopping all LSPs
      startTimeout = 1000 * 5, -- ms, timeout before restart
      silent = true, -- true to suppress notifications
      filetypes = {
        ignore = {
          -- filetypes to ignore; empty by default
          -- lsp-timeout is disabled completely
          -- for these filetypes
        },
      },
    }
  end,
}

return P
