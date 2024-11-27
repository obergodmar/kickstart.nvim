local M = {}

---@return nil
M.apply_action = function(action)
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
M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_buf_create_user_command(bufnr, 'InlayHints', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
  end, { desc = 'Toggle Inlay Hints' })
end

M.get_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  return capabilities
end

return M
