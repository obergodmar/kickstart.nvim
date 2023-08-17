local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  nmap('<leader>f', vim.lsp.buf.format, '[F]ormat current buffer with LSP')
end

local servers = {
  html = {},
  cssls = {},
  -- cssmodules_ls = {},
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
    {
      'creativenull/efmls-configs-nvim',
      dependencies = { 'neovim/nvim-lspconfig' },
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

        require('lspconfig')[server_name].setup({
          settings = servers[server_name],
          capabilities = capabilities,
          on_attach = on_attach,
          root_dir = root_dir,
          init_options = init_options,
          filetypes = filetypes,
        })
      end,
    })

    local efmls = require('efmls-configs')

    efmls.init({
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        documentFormatting = true,
      },
    })

    local luacheck = require('efmls-configs.linters.luacheck')
    local stylua = require('efmls-configs.formatters.stylua')

    local eslint = require('efmls-configs.linters.eslint')
    local prettier = require('efmls-configs.formatters.prettier')
    local stylelint = require('efmls-configs.linters.stylelint')

    local shellcheck = require('efmls-configs.linters.shellcheck')
    local shfmt = require('efmls-configs.formatters.shfmt')

    efmls.setup({
      lua = {
        linter = luacheck,
        formatter = stylua,
      },
      html = {
        formatter = prettier,
      },
      json = {
        formatter = prettier,
      },
      javascript = {
        linter = eslint,
        formatter = prettier,
      },
      typescript = {
        linter = eslint,
        formatter = prettier,
      },
      javascriptreact = {
        linter = eslint,
        formatter = prettier,
      },
      typescriptreact = {
        linter = eslint,
        formatter = prettier,
      },
      css = {
        linter = stylelint,
        formatter = prettier,
      },
      sh = {
        linter = shellcheck,
        formatter = shfmt,
      },
      bash = {
        linter = shellcheck,
        formatter = shfmt,
      },
    })
  end,
}
