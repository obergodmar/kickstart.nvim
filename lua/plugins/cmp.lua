---@diagnostic disable: missing-fields

---@type LazyPluginSpec
local P = {
  'hrsh7th/nvim-cmp',
  version = false, --last release is way too old
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
  },
  opts = function()
    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    local cmp = require('cmp')
    local defaults = require('cmp.config.default')()
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    ---@type cmp.ConfigSchema
    local config = {
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
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
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
    }

    return config
  end,
}

return P
