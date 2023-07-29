local map = vim.keymap.set

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
map('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-Left>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-Down>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-Up>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-Right>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<C-w>Up', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-w>Down', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-w>Left', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-w>Right', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- save file
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })
