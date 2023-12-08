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
  vim = 'indent',

  lua = { 'lsp', 'indent' },
  css = { 'lsp', 'indent' },
  html = { 'lsp', 'indent' },

  php = { 'treesitter', 'indent' },
  json = { 'treesitter', 'indent' },

  javascript = { 'lsp', 'indent' },
  javascriptreact = { 'lsp', 'indent' },
  typescript = { 'lsp', 'indent' },
  typescriptreact = { 'lsp', 'indent' },

  git = { 'treesitter', 'indent' },
}

---@type LazyPluginSpec
local P = {
  -- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
  'kevinhwang91/nvim-ufo',
  dependencies = {
    -- The goal of promise-async is to port Promise & Async from JavaScript to Lua.
    'kevinhwang91/promise-async',
  },
  event = 'VeryLazy',
  keys = {
    {
      'zR',
      "<cmd>lua require('ufo').openAllFolds()<cr>",
      id = 'ufo_open_all_folds',
      desc = 'Open All Folds',
      mode = 'n',
    },
    {
      'zM',
      "<cmd>lua require('ufo').closeAllFolds()<cr>",
      id = 'ufo_close_all_folds',
      desc = 'Close All Folds',
      mode = 'n',
    },
  },
  opts = {
    open_fold_hl_timeout = 400,
    close_fold_kinds = {},
    provider_selector = function(bufnr, filetype, buftype)
      return ftMap[filetype]
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
