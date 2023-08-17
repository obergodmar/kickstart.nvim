local auto_spell_group = vim.api.nvim_create_augroup('AutoSpell', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = auto_spell_group,
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
