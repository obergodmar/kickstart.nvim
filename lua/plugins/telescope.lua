-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    {
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available.
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local nmap = function(keys, func, desc, custom)
      if not custom then
        func = ":lua require'telescope.builtin'." .. func .. "(require('telescope.themes').get_ivy({}))<CR>"
      end

      vim.keymap.set('n', keys, func, { desc = desc })
    end

    local telescope = require 'telescope'
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = require('telescope.actions').cycle_history_next,
            ['<C-d>'] = require('telescope.actions').cycle_history_prev,
            ['<C-s>'] = require('telescope.actions').cycle_previewers_next,
            ['<C-a>'] = require('telescope.actions').cycle_previewers_prev,
          },
        },
      },
    }

    telescope.load_extension 'live_grep_args'
    pcall(telescope.load_extension, 'fzf')

    nmap('<leader>?', 'oldfiles', '[?] Find recently opened files')
    nmap('<leader><space>', 'buffers', '[ ] Find existing buffers')
    nmap('<leader>/', 'resume', '[/] Previous picker')
    nmap('<leader>sf', 'find_files', '[S]earch [F]iles')
    nmap('<leader>sh', 'help_tags', '[S]earch [H]elp')
    nmap('<leader>sg', 'grep_string', '[S]earch [g]rep')
    nmap(
      '<leader>sG',
      ":lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy({}))<CR>",
      '[S]earch [G]rep (args)',
      true
    )
    nmap('<leader>gf', 'git_files', 'Search [G]it [F]iles')
    nmap('<leader>sc', 'git_commits', '[S]earch [C]ommits')
    nmap('<leader>sC', 'git_bcommits', '[S]earch Buffer [C]ommits')
    nmap('<leader>sb', 'git_branches', '[S]earch [B]ranches')
    nmap('<leader>ss', 'git_status', '[S]earch Git [S]tatus')
    nmap('<leader>sS', 'git_stash', '[S]earch Git [S]tash')
    nmap('gI', 'lsp_implementations', '[G]oto [I]mplementations')
  end,
}
