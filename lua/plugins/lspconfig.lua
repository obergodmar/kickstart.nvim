local servers = {
  html = {},
  cssls = {},
  -- cssmodules_ls = {},
  stylelint_lsp = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
    },
  },
  eslint = {},
  tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  bashls = {},
  -- gopls = {
  --   gopls = {
  --     analyses = {
  --       unusedparams = true,
  --       shadow = true,
  --     },
  --     staticcheck = true,
  --   },
  -- },
  intelephense = {},
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      branch = 'legacy',
      opts = {},
    },
    {
      'folke/neodev.nvim',
      opts = {},
    },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    require('mason').setup({})

    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        local lspconfig = require('lspconfig')

        local root_dir = nil
        local init_options = nil
        local filetypes = nil
        local commands = nil
        local autostart = true

        if server_name == 'lua_ls' then
          root_dir = lspconfig.util.root_pattern('.git', '*.rockspec')
        end

        if server_name == 'gopls' then
          root_dir = lspconfig.util.root_pattern('go.work', 'go.mod', '.git')
        end

        if server_name == 'stylelint_lsp' then
          filetypes = {
            'css',
            'less',
            'scss',
            'sugarss',
            'wxss',
            -- "javascript",
            -- "javascriptreact",
            -- "typescript",
            -- "typescriptreact",
          }
        end

        if server_name == 'tsserver' then
          commands = require('lsp.typescript').commands
          init_options = require('lsp.typescript').init_options
        end

        if server_name == 'intelephense' or server_name == 'phpactor' then
          autostart = false
        end

        require('lspconfig')[server_name].setup({
          settings = servers[server_name],
          capabilities = capabilities,
          on_attach = require('lsp.common').on_attach,
          root_dir = root_dir,
          init_options = init_options,
          filetypes = filetypes,
          commands = commands,
          autostart = autostart,
        })
      end,
    })
  end,
}
