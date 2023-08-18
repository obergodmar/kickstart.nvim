local resize_group = vim.api.nvim_create_augroup('ResizeGroup', { clear = true })

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = resize_group,
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})
