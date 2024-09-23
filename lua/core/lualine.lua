local function relative_path_with_path()
  local row = unpack(vim.api.nvim_win_get_cursor(0))

  return vim.fn.expand('%:~:.') .. ':' .. row
end

local function win_num()
  return vim.fn.winnr()
end

local function git_head()
  local buf_name = vim.fn.bufname()

  if buf_name and string.match(buf_name, 'fugitive') then
    return vim.fn.FugitiveStatusline()
  end

  return ''
end

---@type LazyPluginSpec
local P = {
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  'obergodmar/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        {
          'diff',
          diff_color = {
            added = 'GitSignsAdd',
            modified = 'GitSignsChange',
            removed = 'GitSignsDelete',
          },
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn', 'info', 'hint' },
          diagnostics_color = {
            error = 'LualineDiagnosticError',
            warn = 'LualineDiagnosticWarn',
            info = 'LualineDiagnosticInfo',
            hint = 'LualineDiagnosticHint',
          },
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' ',
          },
        },
        'aerial',
      },
      lualine_c = {
        relative_path_with_path,
        'filesize',
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'selectioncount', 'searchcount', 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = { win_num },
      lualine_b = { git_head },
      lualine_c = { relative_path_with_path, 'filesize' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'lazy', 'nvim-tree', 'fzf', 'mason', 'toggleterm', 'aerial' },
  },
}

return P
