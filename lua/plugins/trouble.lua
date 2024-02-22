local keys = require('helpers.search.keys')
local function get_trouble_cmd(fn_name)
  return '<cmd>TroubleToggle ' .. fn_name .. '<cr>'
end

---@type LazyPluginSpec
local P = {
  -- A pretty diagnostics, references, telescope results,
  -- quickfix and location list to help you solve all
  -- the trouble your code is causing.
  'obergodmar/trouble.nvim',
  enabled = false,
  opts = {
    height = 20,
    padding = false,
    action_keys = {
      close = 'q',
      cancel = '<esc>',
      refresh = 'r',
      jump_close = { '<cr>', '<tab>' },
      open_split = { '<c-x>' },
      open_vsplit = { '<c-v>' },
      open_tab = { '<c-t>' },
      jump = { 'o' },
      toggle_mode = 'm',
      switch_severity = 's',
      toggle_preview = 'P',
      hover = 'K',
      preview = 'p',
      close_folds = { 'zM', 'zm' },
      open_folds = { 'zR', 'zr' },
      toggle_fold = { 'zA', 'za' },
      previous = 'k',
      next = 'j',
    },
  },
  keys = {
    keys.lsp_references(function()
      get_trouble_cmd('lsp_references')
    end, 'trouble'),

    keys.lsp_definitions(function()
      get_trouble_cmd('lsp_definitions')
    end, 'trouble'),

    keys.lsp_implementations(function()
      get_trouble_cmd('lsp_implementations')
    end, 'trouble'),

    keys.file_diagnostics(function()
      get_trouble_cmd('document_diagnostics')
    end, 'trouble'),

    keys.project_diagnostics(function()
      get_trouble_cmd('workspace_diagnostics')
    end, 'trouble'),

    {
      '<leader>st',
      '<cmd>TodoTrouble<CR>',
      id = 'trouble_todo',
      desc = '[S]earch [T]ODO',
      mode = 'n',
    },

    keys.quicklist(function()
      get_trouble_cmd('quickfix')
    end, 'trouble'),
  },
}

return P
