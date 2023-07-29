return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local function get_shell()
      if vim.fn.has 'win32' == 1 then
        return vim.fn.executable 'pwsh' and 'pwsh' or 'powershell'
      end

      return vim.shell
    end

    require('toggleterm').setup {
      shade_terminals = false,
      start_in_insert = true,
      open_mapping = [[<c-\>]],
      shell = get_shell(),
    }

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

    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
  end,
}
