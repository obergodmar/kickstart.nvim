local disable_ST_group = vim.api.nvim_create_augroup('DisableST', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = disable_ST_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
