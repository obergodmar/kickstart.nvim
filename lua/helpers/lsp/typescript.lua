local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }

  vim.lsp.buf.execute_command(params)
end

return {
  commands = {
    OrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
    AddMissingImports = {
      function()
        require('helpers.lsp.common').apply_action('source.addMissingImports')
      end,
      description = 'Add Missing Imports',
    },
    RemoveUnusedImports = {
      function()
        require('helpers.lsp.common').apply_action('source.removeUnusedImports')
      end,
      description = 'Remove Unused Imports',
    },
  },
  init_options = {
    hostInfo = 'neovim',
    plugins = {
      -- 'typescript-styled-plugin',
    },
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
    },
    tsserver = {
      useSyntaxServer = 'auto',
    },
    maxTsServerMemory = 8192,
  },
}
