---@type LazyPluginSpec
local P = {
  'obergodmar/git-conflict.nvim',
  cmd = {
    'GitConflictChooseOurs',
    'GitConflictChooseTheirs',
    'GitConflictChooseBoth',
    'GitConflictChooseNone',
    'GitConflictNextConflict',
    'GitConflictPrevConflict',
    'GitConflictListQf',
  },
  keys = {
    {
      '<leader>ko',
      '<Plug>(git-conflict-ours)',
      desc = 'Choose our version',
    },
    {
      '<leader>kt',
      '<Plug>(git-conflict-theirs)',
      desc = 'Choose their version',
    },
    {
      '<leader>kb',
      '<Plug>(git-conflict-both)',
      desc = 'Choose both versions',
    },
    {
      '<leader>kn',
      '<Plug>(git-conflict-none)',
      desc = 'Choose no version',
    },
    {
      '[x',
      '<Plug>(git-conflict-prev-conflict)',
      desc = 'Previous conflict',
    },
    {
      ']x',
      '<Plug>(git-conflict-next-conflict)',
      desc = 'Next conflict',
    },
  },
  opts = {
    default_mappings = false,
    default_commands = true,
    disable_diagnostics = true,
  },
}

return P
