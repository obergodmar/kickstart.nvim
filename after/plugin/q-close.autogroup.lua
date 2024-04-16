local close_with_q_group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = close_with_q_group,
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'checkhealth',
    'fzf',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
