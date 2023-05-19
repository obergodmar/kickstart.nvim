vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local nmap_telescope = function(keys, func, desc, custom)
  if not custom then
    func = ":lua require'telescope.builtin'." .. func .. "(require('telescope.themes').get_ivy({}))<CR>"
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

nmap_telescope('<leader>?', 'oldfiles', '[?] Find recently opened files')
nmap_telescope('<leader><space>', 'buffers', '[ ] Find existing buffers')
nmap_telescope('<leader>/', 'resume', '[/] Previous picker')
nmap_telescope('<leader>sf', 'find_files', '[S]earch [F]iles')
nmap_telescope('<leader>sh', 'help_tags', '[S]earch [H]elp')
nmap_telescope('<leader>sg', 'grep_string', '[S]earch [g]rep')
nmap_telescope('<leader>sG',
  ":lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy({}))<CR>",
  '[S]earch [G]rep (grep)', true)
nmap_telescope('<leader>sd', 'diagnostics', '[S]earch [D]iagnostics')
nmap_telescope('<leader>sc', 'git_commits', '[S]earch [C]ommits')
nmap_telescope('<leader>sC', 'git_bcommits', '[S]earch Buffer [C]ommits')
nmap_telescope('<leader>sb', 'git_branches', '[S]earch [B]ranches')
nmap_telescope('<leader>ss', 'git_status', '[S]earch Git [S]tatus')
nmap_telescope('<leader>sS', 'git_stash', '[S]earch Git [S]tash')

nmap_telescope('gr', 'lsp_references', '[G]oto [R]eferences')
nmap_telescope('gd', 'lsp_definitions', '[G]oto [D]efinitions')
nmap_telescope('gI', 'lsp_implementations', '[G]oto [I]mplementations')
nmap_telescope('<leader>D', 'lsp_type_definitions', 'Type [D]efinitions')

-- Lspsaga keymaps
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>", { desc = "[R]e[n]ame" })
vim.keymap.set("n", "rN", "<cmd>Lspsaga rename ++project<CR>", { desc = "[R]e[n]ame Everywhere" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true, desc = "[T]ab [A]dd" })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "[T]ab [C]lose" })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true, desc = "[T]ab [O]nly (Close other tabs)" })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true, desc = "[T]ab [N]ext" })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true, desc = "[Tab] [P]revious" })
-- move current tab to previous position
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>",
  { noremap = true, desc = "[T]ab [M]ove to [P]revious position" })
-- move current tab to next position
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>",
  { noremap = true, desc = "[Tab] [M]ove to [N]ext position " })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- vim.api.nvim_set_keymap("n", "<leader>f", ":NvimTreeFindFile<CR>", { desc = "[F]ind opened file in NvimTree" })
