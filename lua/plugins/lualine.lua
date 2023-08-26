---@type LazyPluginSpec

local function win_num()
  return vim.fn.winnr()
end

local function git_head()
  local buf_name = vim.fn.bufname()

  if string.match(buf_name, 'fugitive') then
    return vim.fn.FugitiveStatusline()
  end

  return ''
end

local P = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'kanagawa',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename', 'filesize' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'selectioncount', 'searchcount', 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = { win_num },
      lualine_b = { git_head },
      lualine_c = { 'filename', 'filesize' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'lazy' },
  },
}

return P
