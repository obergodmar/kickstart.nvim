vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if vim.g.neovide then
  if vim.fn.has('win32') == 1 then
    vim.o.guifont = 'Iosevka Nerd Font:b:h12'
  else
    vim.o.guifont = 'Iosevka Nerd Font:b:h15'
  end
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_underline_automatic_scaling = false
  vim.g.neovide_confirm_quit = true
end

local vim_data_path = vim.fn.stdpath('data')
local lazypath = vim_data_path .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },
}, {
  root = vim_data_path .. '/plugins',
})
