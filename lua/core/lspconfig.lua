---@diagnostic disable: missing-fields

---@type LazyPluginSpec[]
local P = {
  require('helpers.lsp.nvim-lsp').nvim_lsp,
  require('helpers.lsp.coc').coc,
}

return P
