local on_attach = require('helpers.lsp.common').on_attach

local servers = {
  marksman = {},
  html = {},
  cssls = {},
  typos_lsp = {},
  cssmodules_ls = {},
  stylelint_lsp = {
    stylelintplus = {
      autoFixOnSave = false,
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
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    'williamboman/mason.nvim',
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    'williamboman/mason-lspconfig.nvim',
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          'lazy.nvim',
        },
      },
    },
    {
      'pmizio/typescript-tools.nvim',
      dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      opts = {
        on_attach = require('helpers.lsp.common').on_attach,
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
    {
      'mfussenegger/nvim-jdtls',
      ft = 'java',
    },
    {
      'Zeioth/garbage-day.nvim',
      dependencies = 'neovim/nvim-lspconfig',
      event = 'VeryLazy',
      opts = {
        aggressive_mode = true,
      },
    },
    {
      'ray-x/lsp_signature.nvim',
      event = 'VeryLazy',
      opts = {
        hint_prefix = ' ',
      },
    },
    {
      'nvimdev/lspsaga.nvim',
      event = 'LspAttach',
      opts = {
        lightbulb = {
          enable = false,
        },
        ui = {
          devicon = true,
        },
        symbol_in_winbar = {
          enable = false,
          respect_root = true,
        },
        code_action = {
          show_server_name = true,
          extend_gitsigns = true,
        },
      },
      keys = {
        {
          '<leader>ca',
          '<cmd>Lspsaga code_action<CR>',
          id = 'lspsaga_code_action',
          desc = '[C]ode [A]ction',
          mode = { 'n', 'v' },
        },
        {
          'cr',
          '<cmd>Lspsaga rename<CR>',
          id = 'lspsaga_rename',
          desc = '[R]e[n]ame',
          mode = 'n',
        },
        {
          'cR',
          '<cmd>Lspsaga rename ++project<CR>',
          id = 'lspsaga_rename_all',
          desc = '[R]e[n]ame Everywhere',
          mode = 'n',
        },
        {
          'K',
          '<cmd>Lspsaga hover_doc<CR>',
          id = 'lspsaga_hover_doc',
          desc = 'Hover documentation',
          mode = 'n',
        },
        {
          '<leader>e',
          '<cmd>Lspsaga show_line_diagnostics<CR>',
          id = 'lspsaga_show_line_diagnostics',
          desc = 'Open floating diagnostic message (current line)',
          mode = 'n',
        },
        {
          '[d',
          '<cmd>Lspsaga diagnostic_jump_prev<CR>',
          id = 'lspsaga_diagnostic_jump_prev',
          desc = 'Go to previous diagnostic message',
          mode = 'n',
        },
        {
          ']d',
          '<cmd>Lspsaga diagnostic_jump_next<CR>',
          id = 'lspsaga_diagnostic_jump_next',
          desc = 'Go to next diagnostic message',
          mode = 'n',
        },
        {
          'ga',
          '<cmd>Lspsaga finder ref+def+imp<CR>',
          id = 'lspsaga_finder_ref_def_imp',
          desc = '[G]oto [A]ll',
          mode = 'n',
        },
      },
    },
  },
  config = function()
    local capabilities = require('helpers.lsp.common').get_capabilities()

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
        local handlers = nil
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

        if server_name == 'java_language_server' then
          handlers = {
            ['client/registerCapability'] = function(err, result, ctx, config)
              local registration = {
                registrations = { result },
              }
              return vim.lsp.handlers['client/registerCapability'](err, registration, ctx, config)
            end,
          }
        end

        if server_name == 'typos_lsp' then
          init_options = {
            diagnosticSeverity = 'Hint',
          }
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
          handlers = handlers,
        })
      end,
    })
  end,
  keys = {
    {
      '<leader>R',
      function()
        require('garbage-day.utils').stop_lsp()
      end,
      mode = 'n',
      desc = 'Stop LSP',
      { noremap = true, silent = true },
    },
    {
      '<leader>T',
      function()
        require('garbage-day.utils').start_lsp()
      end,
      mode = 'n',
      desc = 'Start LSP',
      { noremap = true, silent = true },
    },
  },
}

return P
