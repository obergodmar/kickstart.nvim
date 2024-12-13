---@diagnostic disable: missing-fields
---@type LazyPluginSpec
local P = {
  -- A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- nvim-cmp source for neovim's built-in language server client.
    'hrsh7th/cmp-nvim-lsp',
    -- nvim-cmp source for buffer words.
    'hrsh7th/cmp-buffer',
    -- nvim-cmp source for filesystem paths.
    'hrsh7th/cmp-path',
    -- nvim-cmp source for commands.
    'hrsh7th/cmp-cmdline',
    -- luasnip completion source for nvim-cmp
    {
      'saadparwaiz1/cmp_luasnip',
      dependencies = {
        -- Snippet engine for neovim written in Lua.
        {
          'L3MON4D3/LuaSnip',
          build = (not jit.os:find('Windows')) and 'make install_jsregexp' or nil,
          dependencies = {
            -- Snippets collection for a set of different programming languages.
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
          opts = {
            history = true,
            delete_check_events = 'TextChanged',
          },
        },
      },
    },
    -- This tiny plugin adds vscode-like pictograms to neovim built-in lsp.
    'onsails/lspkind.nvim',
  },
  keys = {},
  config = function()
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
        -- ['<S-CR>'] = cmp.mapping.confirm({
        --   behavior = cmp.ConfirmBehavior.Replace,
        --   select = true,
        -- }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
        {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
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
        debounce = 0,
        throttle = 0,
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
