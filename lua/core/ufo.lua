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

---@type LazyPluginSpec
local P = {
  -- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
  'obergodmar/nvim-ufo',
  dependencies = {
    -- The goal of promise-async is to port Promise & Async from JavaScript to Lua.
    'obergodmar/promise-async',
  },
  event = 'VeryLazy',
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
    provider_selector = function()
      return { 'treesitter', 'indent' }
    end,
    enable_get_fold_virt_text = true,
    fold_virt_text_handler = create_fold_virt_text,
  },
  init = function()
    vim.o.foldcolumn = '0' -- disable this because statuscol is in use
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
}

return P
