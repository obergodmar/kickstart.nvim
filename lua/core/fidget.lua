local P = {
  -- Extensible UI for Neovim notifications and LSP progress messages.
  'obergodmar/fidget.nvim',
  opts = {
    notification = {
      override_vim_notify = true,
    },
    progress = {
      ignore_empty_message = false,
    },
  },
}

return P
