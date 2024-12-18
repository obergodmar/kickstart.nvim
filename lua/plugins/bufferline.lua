local function mapBufferlineKeys(goToIndex)
  return {
    '<leader>' .. goToIndex,
    '<cmd>lua require("bufferline").go_to(' .. goToIndex .. ', true)<cr>',
    id = 'bufferline_go_to_' .. goToIndex,
    desc = 'Go to ' .. goToIndex .. ' tab',
    mode = 'n',
  }
end

local keys = {}
for i = 1, 9, 1 do
  table.insert(keys, mapBufferlineKeys(i))
end

---@type LazyPluginSpec
local P = {
  -- Tabs replacer
  'akinsho/bufferline.nvim',
  version = "*",
  event = 'BufEnter',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    ---@type bufferline.Options
    ---@diagnostic disable-next-line: missing-fields
    options = {
      mode = 'tabs',
      numbers = 'ordinal',
      indicator = { style = 'underline' },
      diagnostics = 'nvim_lsp',
      color_icons = true,
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_duplicate_prefix = false,
      show_close_icon = false,
      separator_style = 'thin',
    },
  },
  keys = keys,
}

return P
