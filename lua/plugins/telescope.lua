---@return string
local get_ts_cmd = function(fn_name)
  return "<cmd>lua require'telescope.builtin'." .. fn_name .. "(require('telescope.themes').get_ivy({}))<cr>"
end

---@type LazyPluginSpec
local P = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    {
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available.
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      cond = function()
        return vim.fn.executable('cmake') == 1
      end,
    },
    {
      'aaronhallaert/advanced-git-search.nvim',
    },
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        preview = {
          treesitter = false,
        },
        mappings = {
          i = {
            ['<C-u>'] = require('telescope.actions').cycle_history_next,
            ['<C-d>'] = require('telescope.actions').cycle_history_prev,
            ['<C-s>'] = require('telescope.actions').cycle_previewers_next,
            ['<C-a>'] = require('telescope.actions').cycle_previewers_prev,
          },
        },
      },
      extensions = {},
    })

    telescope.load_extension('live_grep_args')
    telescope.load_extension('advanced_git_search')
    pcall(telescope.load_extension, 'fzf')
  end,
  keys = {
    {
      '<leader>?',
      get_ts_cmd('oldfiles'),
      id = 'ts_oldfiles',
      desc = '[?] Find recently opened files',
      mode = 'n',
    },
    {
      '<leader><space>',
      get_ts_cmd('buffers'),
      id = 'ts_buffers',
      desc = '[ ] Find existing buffers',
      mode = 'n',
    },
    {
      '<leader>/',
      get_ts_cmd('resume'),
      id = 'ts_resume_search',
      desc = '[/] Previous picker',
      mode = 'n',
    },
    {
      id = 'ts_files',
      '<leader>sf',
      get_ts_cmd('find_files'),
      desc = '[S]earch [F]iles',
      mode = 'n',
    },
    {

      '<leader>sg',
      'grep_string',
      id = 'ts_grep_string',
      desc = '[S]earch [g]rep',
      mode = 'n',
    },
    {
      '<leader>sG',
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy {})<cr>",
      id = 'ts_grep_string_args',
      desc = '[S]earch [G]rep (args)',
      mode = 'n',
    },
    {
      '<leader>gf',
      get_ts_cmd('git_files'),
      id = 'ts_git_files',
      desc = 'Search [G]it [F]iles',
      mode = 'n',
    },
    {
      '<leader>sc',
      get_ts_cmd('git_commits'),
      id = 'ts_git_commits',
      desc = '[S]earch [C]ommits',
      mode = 'n',
    },
    {
      '<leader>sC',
      get_ts_cmd('git_bcommits'),
      id = 'ts_git_buffer_commits',
      desc = '[S]earch Buffer [C]ommits',
      mode = 'n',
    },
    {
      '<leader>sb',
      get_ts_cmd('git_branches'),
      id = 'ts_git_branches',
      desc = '[S]earch [B]ranches',
      mode = 'n',
    },
    {
      '<leader>ss',
      get_ts_cmd('git_status'),
      id = 'ts_git_status',
      desc = '[S]earch Git [S]tatus',
      mode = 'n',
    },
    {
      '<leader>sS',
      get_ts_cmd('git_stash'),
      id = 'ts_git_stash',
      desc = '[S]earch Git [S]tash',
      mode = 'n',
    },
    {
      'gI',
      get_ts_cmd('lsp_implementations'),
      id = 'ts_impl',
      desc = '[G]oto [I]mplementations',
      mode = 'n',
    },
  },
}

return P
