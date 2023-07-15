vim.g.mapleader = " "
vim.g.maplocalleader = " "

local vim_data_path = vim.fn.stdpath("data")
local lazypath = vim_data_path .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  { import = "plugins" },
}, {
  root = vim_data_path .. "/plugins",
})
