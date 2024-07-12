local vim_data_path = vim.fn.stdpath('data')
local plug_dir = vim_data_path .. '/site/autoload/plug.vim'
if not vim.loop.fs_stat(plug_dir) then
  vim.fn.system({
    'curl',
    '-fLo',
    plug_dir,
    '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
  })
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
Plug('obergodmar/vim-fugitive')

vim.call('plug#end')
