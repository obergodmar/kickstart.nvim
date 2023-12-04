local glyph_palette_group = vim.api.nvim_create_augroup('GlyphPalette', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = glyph_palette_group,
  pattern = {
    'fern',
  },
  callback = function()
    vim.cmd('call glyph_palette#apply()')
  end,
})
