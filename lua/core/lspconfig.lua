local on_attach = require('helpers.lsp.common').on_attach

local servers = {
  marksman = {},
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
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
  bashls = {},
  gopls = {
    gopls = {
      ['ui.inlayhint.hints'] = {
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
      },
    },
  },
  intelephense = {},
}

---@type LazyPluginSpec
local P = {
  -- Quickstart configs for Nvim LSP
  'obergodmar/nvim-lspconfig',
  dependencies = {
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    'obergodmar/mason.nvim',
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    'obergodmar/mason-lspconfig.nvim',
    {
      'obergodmar/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          'lazy.nvim',
        },
      },
    },
    {
      'obergodmar/typescript-tools.nvim',
      opts = {
        settings = {
          tsserver_logs = 'verbose',
          separate_diagnostic_server = false,
          publish_diagnostic_on = 'insert_leave',
          expose_as_code_action = {
            'fix_all',
            'add_missing_imports',
            'remove_unused',
          },
          tsserver_path = nil,
          tsserver_plugins = {},
          tsserver_max_memory = 4096,
          tsserver_format_options = {},
          complete_function_calls = true,
          jsx_close_tag = {
            enable = true,
            filetypes = { 'javascriptreact', 'typescriptreact' },
          },
          tsserver_file_preferences = function()
            return {
              includeCompletionsForImportStatements = true,
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
              importModuleSpecifierPreference = 'auto',
              includeInlayParameterNameHints = 'all',
              includeCompletionsForModuleExports = true,
              quotePreference = 'auto',
            }
          end,
        },
      },
    },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason').setup({
      ui = {
        width = 1.0,
        height = 1.0,
      },
    })

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

          root_dir = lspconfig.util.root_pattern('.stylelintrc', 'package.json', '.git')
        end

        if server_name == 'eslint' then
          filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
          }
        end

        if server_name == 'intelephense' or server_name == 'phpactor' then
          autostart = false
        end

        lspconfig[server_name].setup({
          settings = servers[server_name],
          capabilities = capabilities,
          on_attach = on_attach,
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

return P
