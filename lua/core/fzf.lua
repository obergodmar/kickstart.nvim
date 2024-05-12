local keys = require('helpers.search.keys')

---@type LazyPluginSpec
local P = {
  'obergodmar/fzf-lua',
  branch = require('helpers.utils').is_win() and 'windows' or 'master',
  dependencies = {
    'obergodmar/nvim-web-devicons',
  },
  opts = {
    files = {
      fzf_opts = {
        ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-files-history',
      },
    },
    grep = {
      fzf_opts = {
        ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-grep-history',
      },
    },
    winopts = {
      preview = {
        default = 'bat',
      },
    },
    manpages = { previewer = 'man_native' },
    helptags = { previewer = 'help_native' },
    tags = { previewer = 'bat' },
    btags = { previewer = 'bat' },
  },
  keys = {
    keys.oldfiles(function()
      vim.cmd('rshada!')
      require('fzf-lua').oldfiles({ cwd_only = true })
    end, 'fzf'),

    keys.buffers(function()
      require('fzf-lua').buffers()
    end, 'fzf'),

    keys.resume(function()
      require('fzf-lua').resume()
    end, 'fzf'),

    keys.find_files(function()
      require('fzf-lua').files()
    end, 'fzf'),

    keys.grep_string(function()
      require('fzf-lua').grep_cword()
    end, 'fzf'),

    keys.live_grep(function()
      require('fzf-lua').live_grep_native()
    end, 'fzf'),

    keys.live_grep_args(function()
      require('fzf-lua').live_grep_glob()
    end, 'fzf'),

    keys.git_files(function()
      require('fzf-lua').git_files()
    end, 'fzf'),

    keys.git_commits(function()
      require('fzf-lua').git_commits()
    end, 'fzf'),

    keys.git_bcommits(function()
      require('fzf-lua').git_bcommits()
    end, 'fzf'),

    keys.git_branches(function()
      require('fzf-lua').git_branches()
    end, 'fzf'),

    keys.git_status(function()
      require('fzf-lua').git_status()
    end, 'fzf'),

    keys.git_stash(function()
      require('fzf-lua').git_stash()
    end, 'fzf'),

    keys.lsp_references(function()
      require('fzf-lua').lsp_references()
    end, 'fzf'),

    keys.lsp_definitions(function()
      require('fzf-lua').lsp_definitions()
    end, 'fzf'),

    keys.lsp_implementations(function()
      require('fzf-lua').lsp_implementations()
    end, 'fzf'),

    keys.file_diagnostics(function()
      require('fzf-lua').diagnostics_document()
    end, 'fzf'),

    keys.project_diagnostics(function()
      require('fzf-lua').diagnostics_workspace()
    end, 'fzf'),

    keys.quicklist(function()
      require('fzf-lua').quicklist()
    end, 'fzf'),

    keys.reglist(function()
      require('fzf-lua').registers()
    end, 'fzf'),
  },
}

return P
