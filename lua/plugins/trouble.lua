local function get_trouble_cmd(fn_name)
  return '<cmd>TroubleToggle ' .. fn_name .. '<cr>'
end

---@type LazyPluginSpec
local P = {
  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  'folke/trouble.nvim',
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
    {
      'gr',
      get_trouble_cmd('lsp_references'),
      id = 'trouble_refs',
      desc = '[G]oto [R]eferences',
      mode = 'n',
    },
    {
      'gd',
      get_trouble_cmd('lsp_definitions'),
      id = 'trouble_defs',
      desc = '[G]oto [D]efinitions',
      mode = 'n',
    },
    {
      'gI',
      get_trouble_cmd('lsp_implementations'),
      id = 'trouble_impls',
      desc = '[G]ot [I]mplementations',
      mode = 'n',
    },
    {
      '<leader>sd',
      get_trouble_cmd('document_diagnostics'),
      id = 'trouble_file_diagnostics',
      desc = '[S]earch [D]iagnostics',
      mode = 'n',
    },
    {
      '<leader>sD',
      get_trouble_cmd('workspace_diagnostics'),
      id = 'trouble_workspace_diagnostics',
      desc = '[S]earch [D]iagnostics',
      mode = 'n',
    },
    {
      '<leader>st',
      '<cmd>TodoTrouble<CR>',
      id = 'trouble_todo',
      desc = '[S]earch [T]ODO',
      mode = 'n',
    },
    {
      '<leader>sq',
      get_trouble_cmd('quickfix'),
      id = 'trouble_quickfix',
      desc = '[S]how [Q]uick List',
      mode = 'n',
    },
  },
}

return P
