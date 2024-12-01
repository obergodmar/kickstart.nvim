local P = {
  -- Extensible UI for Neovim notifications and LSP progress messages.
  'j-hui/fidget.nvim',
  opts = {
    notification = {
      override_vim_notify = true,
    },
    progress = {
      suppress_on_insert = true,
      ignore_done_already = true,
      ignore_empty_message = true,
    },
  },
}
return P
