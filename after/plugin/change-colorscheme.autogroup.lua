local auto_colorscheme_group = vim.api.nvim_create_augroup('AutoColorScheme', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = auto_colorscheme_group,
  callback = function()
    vim.cmd.colorscheme(vim.o.background == 'dark' and 'kanagawa-wave' or 'kanagawa-lotus')
  end,
})
