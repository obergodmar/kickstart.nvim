local create_fold_virt_text = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'LspAttach',
  keys = {
    {
      'zR',
      "<cmd>require('ufo').openAllFolds()<cr>",
      id = 'ufo_open_all_folds',
      desc = 'Open All Folds',
      mode = 'n',
    },
    {
      'zM',
      "<cmd>require('ufo').closeAllfolds()<cr>",
      id = 'ufo_close_all_folds',
      desc = 'Close All Folds',
      mode = 'n',
    },
  },
  config = function()
    require('ufo').setup({
      open_fold_hl_timeout = 150,
      close_fold_kinds = { 'imports', 'comment' },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
      ---@diagnostic disable-next-line: unused-local
      provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype]
      end,
      enable_get_fold_virt_text = true,
      fold_virt_text_handler = create_fold_virt_text,
    })
  end,
}

return P
