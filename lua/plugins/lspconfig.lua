local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }

  vim.lsp.buf.execute_command(params)
end

local function apply_lsp_action(action)
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

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
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
  gopls = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
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
          commands = {
            OrganizeImports = {
              organize_imports,
              description = 'Organize Imports',
            },
            AddMissingImports = {
              function()
                apply_lsp_action('source.addMissingImports')
              end,
              description = 'Add Missing Imports',
            },
            RemoveUnusedImports = {
              function()
                apply_lsp_action('source.removeUnusedImports')
              end,
              description = 'Remove Unused Imports',
            },
          }
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
          }
        end

        require('lspconfig')[server_name].setup({
          settings = servers[server_name],
          capabilities = capabilities,
          on_attach = on_attach,
          root_dir = root_dir,
          init_options = init_options,
          filetypes = filetypes,
          commands = commands,
        })
      end,
    })
  end,
}
