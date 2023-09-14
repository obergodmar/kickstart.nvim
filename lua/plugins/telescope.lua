---@return string
local get_ts_cmd = function(fn_name)
  return "<cmd>lua require'telescope.builtin'." .. fn_name .. "(require('telescope.themes').get_ivy({}))<cr>"
end

---@type LazyPluginSpec
local P = {
  'nvim-telescope/telescope.nvim',
  commit = '057ee0f8783872635bc9bc9249a4448da9f99123',
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
    local telescope_config = require('telescope.config')
    local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

    table.insert(vimgrep_arguments, '--hidden')
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git/*')
    table.insert(vimgrep_arguments, '--trim')

    local actions = require('telescope.actions')
    local action_layout = require('telescope.actions.layout')
    local previewers = require('telescope.previewers')

    local previewers_utils = require('telescope.previewers.utils')

    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}

      filepath = vim.fn.expand(filepath)
      vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
          return
        end
        if stat.size > 100000 then
          return
        else
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
      end)
    end

    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        buffer_previewer_maker = new_maker,
        preview = {
          treesitter = false,
          mime_hook = function(_, bufnr, opts)
            previewers_utils.set_preview_message(bufnr, opts.winid, 'Binary cannot be previewed')
          end,
        },
        mappings = {
          n = {
            ['<M-p>'] = action_layout.toggle_preview,
          },
          i = {
            ['<C-u>'] = actions.cycle_history_next,
            ['<C-d>'] = actions.cycle_history_prev,
            ['<C-s>'] = actions.cycle_previewers_next,
            ['<C-a>'] = actions.cycle_previewers_prev,
            ['<M-p>'] = action_layout.toggle_preview,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
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
      '<leader>sf',
      get_ts_cmd('find_files'),
      id = 'ts_files',
      desc = '[S]earch [F]iles',
      mode = 'n',
    },
    {
      '<leader>sg',
      get_ts_cmd('grep_string'),
      id = 'ts_grep_string',
      desc = '[S]earch [g]rep',
      mode = 'n',
    },
    {
      '<leader>sG',
      get_ts_cmd('live_grep'),
      id = 'ts_live_grep',
      desc = '[S]earch Live [G]rep',
      mode = 'n',
    },
    {
      '<leader>sa',
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy {})<cr>",
      id = 'ts_live_grep_args',
      desc = '[S]earch Live Grep ([A]rgs)',
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
