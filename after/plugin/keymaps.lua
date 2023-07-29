vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.api.nvim_set_keymap('n', '<leader>ta', ':$tabnew<CR>', { noremap = true, desc = '[T]ab [A]dd' })
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = '[T]ab [C]lose' })
vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true, desc = '[T]ab [O]nly (Close other tabs)' })
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabn<CR>', { noremap = true, desc = '[T]ab [N]ext' })
vim.api.nvim_set_keymap('n', '<leader>tp', ':tabp<CR>', { noremap = true, desc = '[Tab] [P]revious' })
-- move current tab to previous position
vim.api.nvim_set_keymap('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true, desc = '[T]ab [M]ove to [P]revious position' })
--
-- move current tab to next position
vim.api.nvim_set_keymap('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true, desc = '[Tab] [M]ove to [N]ext position ' })
