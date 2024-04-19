vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
  pattern = '*',
  command = 'wshada',
})
