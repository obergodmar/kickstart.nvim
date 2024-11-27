local function get_relative_path()
  local bufname = vim.fn.expand('%:t') -- Get the filename
  local ext = vim.fn.expand('%:e')
  if bufname == '' or ext == '' then
    return nil -- No filename or extension, return nil for non-file buffers
  end
  local filepath = vim.fn.expand('%:~:.') -- Relative to the current directory
  local win_width = vim.api.nvim_win_get_width(0) -- Width of the current buffer window
  local max_path_length = math.max(win_width - 10, 10) -- Reserve space for icons and modification indicators

  -- Truncate the path if it exceeds the current window width
  if #filepath > max_path_length then
    filepath = string.sub(filepath, -1 * max_path_length)
  end

  return filepath
end

local function get_icon()
  local filename = vim.fn.expand('%:t')
  local ext = vim.fn.expand('%:e')

  local icon
  pcall(function()
    icon = require('nvim-web-devicons').get_icon(filename, ext, { default = true })
  end)

  return icon and (icon .. ' ') or ''
end

local function is_modified()
  if vim.bo.modified then
    return ' [+]' -- Show modification indicator
  end
  return ''
end

local function winbar_content()
  local filepath = get_relative_path()
  if not filepath then
    return nil -- Clear winbar for non-file buffers
  end
  return get_icon() .. filepath .. is_modified()
end

-- Set up the winbar dynamically
vim.api.nvim_create_autocmd(
  { 'BufWinEnter', 'BufWritePost', 'BufEnter', 'TextChanged', 'TextChangedI', 'WinResized', 'WinEnter' },
  {
    callback = function()
      local content = winbar_content()
      if content then
        vim.wo.winbar = content
      else
        vim.wo.winbar = nil -- Clear winbar for non-file buffers
      end
    end,
  }
)
