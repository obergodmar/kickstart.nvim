local keys = require('search.keys')

---@return string
local get_ts_cmd = function(fn_name)
  return "<cmd>lua require'telescope.builtin'." .. fn_name .. "(require('telescope.themes').get_ivy({}))<cr>"
end

---@type LazyPluginSpec
local P = {
  -- telescope.nvim is a highly extendable fuzzy finder over lists.
  -- Built on the latest awesome features from neovim core.
  -- Telescope is centered around modularity, allowing for easy customization.
  'obergodmar/telescope.nvim',
  enabled = false,
  dependencies = {
    -- All the lua functions I don't want to write twice.
    'obergodmar/plenary.nvim',
    -- Live grep with args
    'obergodmar/telescope-live-grep-args.nvim',
    {
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available.
      'obergodmar/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      cond = function()
        return vim.fn.executable('cmake') == 1
      end,
    },
    {
      -- Search your git history by commit message, content and author in Neovim
      'obergodmar/advanced-git-search.nvim',
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
      ---@diagnostic disable-next-line: param-type-mismatch
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
    local trouble = require('trouble.providers.telescope')

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
            ['<c-t>'] = trouble.open_with_trouble,
          },
          i = {
            ['<C-u>'] = actions.cycle_history_next,
            ['<C-d>'] = actions.cycle_history_prev,
            ['<C-s>'] = actions.cycle_previewers_next,
            ['<C-a>'] = actions.cycle_previewers_prev,
            ['<c-t>'] = trouble.open_with_trouble,
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
            theme = 'ivy',
          },
        },
      },
      pickers = {
        oldfiles = {
          theme = 'ivy',
        },
        find_files = {
          theme = 'ivy',
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
        grep_string = {
          theme = 'ivy',
        },
        live_grep = {
          theme = 'ivy',
        },
        git_files = {
          theme = 'ivy',
        },
      },
    })

    telescope.load_extension('live_grep_args')
    telescope.load_extension('advanced_git_search')
    pcall(telescope.load_extension, 'fzf')
  end,
  keys = {
    keys.oldfiles(function()
      require('telescope.custom-pickers').custom_files_picker({ picker = 'oldfiles' })
    end, 'ts'),

    keys.buffers(function()
      get_ts_cmd('buffers')
    end, 'ts'),

    keys.resume(function()
      get_ts_cmd('resume')
    end, 'ts'),

    keys.find_files(function()
      require('telescope.custom-pickers').custom_files_picker({ picker = 'find_files' })
    end, 'ts'),

    keys.grep_string(function()
      require('telescope.custom-pickers').custom_grep_picker({ picker = 'grep_string' })
    end, 'ts'),

    keys.live_grep(function()
      require('telescope.custom-pickers').custom_grep_picker({ picker = 'live_grep' })
    end, 'ts'),

    keys.live_grep_args(function()
      require('telescope.custom-pickers').custom_grep_picker({ picker = 'live_grep_args' })
    end, 'ts'),

    keys.git_files(function()
      require('telescope.custom-pickers').custom_files_picker({ picker = 'git_files' })
    end, 'ts'),

    keys.git_commits(function()
      get_ts_cmd('git_commits')
    end, 'ts'),

    keys.git_bcommits(function()
      get_ts_cmd('git_bcommits')
    end, 'ts'),

    keys.git_branches(function()
      get_ts_cmd('git_branches')
    end, 'ts'),

    keys.git_status(function()
      get_ts_cmd('git_status')
    end, 'fzf'),

    keys.git_stash(function()
      get_ts_cmd('git_stash')
    end, 'fzf'),
  },
}

return P
