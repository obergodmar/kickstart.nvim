local create_fold_virt_text = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local totalLines = vim.api.nvim_buf_line_count(0)
  local foldedLines = endLnum - lnum
  local suffix = (' 󰁂 %d %d%%'):format(foldedLines, foldedLines / totalLines * 100)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  local rAlignAppndx = math.max(math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth, 0)
  suffix = (' '):rep(rAlignAppndx) .. suffix
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

local ftMap = {
  css = { 'indent' },
}

---@type LazyPluginSpec
local P = {
  -- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
  'obergodmar/nvim-ufo',
  dependencies = {
    -- The goal of promise-async is to port Promise & Async from JavaScript to Lua.
    'obergodmar/promise-async',
  },
  event = 'VimEnter',
  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
      id = 'ufo_open_all_folds',
      desc = 'Open All Folds',
      mode = 'n',
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
      id = 'ufo_close_all_folds',
      desc = 'Close All Folds',
      mode = 'n',
    },
    {
      'zU',
      function()
        require('ufo').enableFold()
      end,
      id = 'ufo_enable_fold',
      desc = 'Enable Fold for buffer',
      mode = 'n',
    },
  },
  opts = {
    open_fold_hl_timeout = 400,
    close_fold_kinds = {},
    enable_get_fold_virt_text = true,
    fold_virt_text_handler = create_fold_virt_text,
    provider_selector = function(_, filetype)
      return ftMap[filetype]
    end,
  },
}

return P
