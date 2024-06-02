---@diagnostic disable: missing-fields
---@type LazyPluginSpec
local P = {
  -- A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
  'obergodmar/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- nvim-cmp source for neovim's built-in language server client.
    'obergodmar/cmp-nvim-lsp',
    -- nvim-cmp source for buffer words.
    'obergodmar/cmp-buffer',
    -- nvim-cmp source for filesystem paths.
    'obergodmar/cmp-path',
    -- nvim-cmp source for commands.
    'obergodmar/cmp-cmdline',
    -- luasnip completion source for nvim-cmp
    'obergodmar/cmp_luasnip',
    -- This tiny plugin adds vscode-like pictograms to neovim built-in lsp.
    'obergodmar/lspkind.nvim',
  },
  keys = {},
  config = function()
    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    local cmp = require('cmp')
    local defaults = require('cmp.config.default')()
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    cmp.setup({
      completion = {
        keyword_length = 1,
        completeopt = 'menu,menuone,noinsert',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-z>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<S-CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'c', 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'c', 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 4 },
        { name = 'path' },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          menu = {
            nvim_lsp = '[LSP]',
            nvim_lua = '[Lua]',
            path = '[Path]',
            buffer = '[Buffer]',
          },
        }),
      },
      experimental = {
        ghost_text = {
          hl_group = 'CmpGhostText',
        },
      },
      sorting = defaults.sorting,
      performance = {
        debounce = 300,
        throttle = 60,
        fetching_timeout = 200,
        max_view_entries = 50,
      },
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}

return P
