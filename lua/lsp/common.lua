---@return nil
local function apply_action(action)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { action } }

  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, 'utf-16')
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

---@return nil
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

return {
  apply_action = apply_action,
  on_attach = on_attach,
}
