-- Make line numbers default
vim.wo.number = true

local toggle_number = vim.api.nvim_create_augroup('NumberToggle', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = toggle_number,
  callback = function()
    vim.cmd [[if &nu && mode() != 'i' | set rnu | endif]]
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = toggle_number,
  callback = function()
    vim.cmd [[if &nu | set nornu | endif]]
  end,
})
