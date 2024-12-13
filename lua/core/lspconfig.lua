---@diagnostic disable: missing-fields
local is_coc_instead_of_lspconfig = true

local add_ufo_folding = function(hoverFn)
  local create_fold_virt_text = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local totalLines = vim.api.nvim_buf_line_count(0)
    local foldedLines = endLnum - lnum
    local suffix = (' 󰁂 %d %d%%'):format(foldedLines, foldedLines / totalLines * 100)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    local rAlignAppndx = math.max(math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth, 0)
    suffix = (' '):rep(rAlignAppndx) .. suffix
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
  end

  local ftMap = {
    css = { 'treesitter', 'indent' },
    php = { 'treesitter', 'indent' },
    git = '',
  }

  return {
    {
      -- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
      'kevinhwang91/nvim-ufo',
      dependencies = {
        -- The goal of promise-async is to port Promise & Async from JavaScript to Lua.
        'kevinhwang91/promise-async',

        {
          'luukvbaal/statuscol.nvim',
          config = function()
            local builtin = require('statuscol.builtin')
            require('statuscol').setup({
              segments = {
                {
                  text = { '%s', builtin.lnumfunc, ' ' },
                },
                {
                  text = {
                    '%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " ") : " " }',
                    ' ',
                  },
                  hl = 'FoldColumn',
                  sign = {
                    name = { '.*' },
                    fillchar = ' ',
                    fillcharhl = nil,
                  },
                },
              },
            })
          end,
        },
      },
      keys = {
        {
          'K',
          hoverFn,
          id = 'ufo_hover_doc',
          desc = 'Hover fold',
          mode = 'n',
        },
        {
          'zR',
          function()
            require('ufo').openAllFolds()
          end,
          id = 'ufo_open_all_folds',
          desc = 'Open All Folds',
          mode = 'n',
        },
        {
          'zM',
          function()
            require('ufo').closeAllFolds()
          end,
          id = 'ufo_close_all_folds',
          desc = 'Close All Folds',
          mode = 'n',
        },
        {
          'zU',
          function()
            require('ufo').enableFold()
          end,
          id = 'ufo_enable_fold',
          desc = 'Enable Fold for buffer',
          mode = 'n',
        },
      },
      opts = {
        open_fold_hl_timeout = 400,
        close_fold_kinds = {},
        enable_get_fold_virt_text = true,
        fold_virt_text_handler = create_fold_virt_text,
        provider_selector = function(_, filetype)
          return ftMap[filetype]
        end,
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0,
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']',
          },
        },
      },
    },
  }
end

---@type LazyPluginSpec[]
local P = {
  {
    -- Quickstart configs for Nvim LSP
    'neovim/nvim-lspconfig',
    enabled = not is_coc_instead_of_lspconfig,
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
            '<leader>cr',
            '<cmd>Lspsaga rename<CR>',
            id = 'lspsaga_rename',
            desc = '[R]e[n]ame',
            mode = 'n',
          },
          {
            '<leader>cR',
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
      {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
      },
      {
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
      },
      {
        -- Extensible UI for Neovim notifications and LSP progress messages.
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            override_vim_notify = true,
          },
          progress = {
            suppress_on_insert = true,
            ignore_done_already = true,
            ignore_empty_message = true,
          },
        },
      },
      add_ufo_folding(function()
        vim.lsp.buf.hover()
      end),
    },
    config = function()
      local servers = {
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        },
      }

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

      local on_attach = require('helpers.lsp.common').on_attach
      local capabilities = require('helpers.lsp.common').get_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

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
  },
  {
    'neoclide/coc.nvim',
    branch = 'master',
    enabled = is_coc_instead_of_lspconfig,
    build = 'npm ci & npm run build',
    dependencies = {
      add_ufo_folding(function()
        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
      end),
    },
    config = function()
      require('ufo').setup()

      vim.g.coc_global_extensions = {
        'coc-typos',
        'coc-pairs',
        'coc-json',

        'coc-tsserver',
        'coc-css',
        'coc-html',
        'coc-eslint',
      }

      -- Function definitions
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      -- Keybindings
      require('which-key').add({
        -- NORMAL mode mappings
        {
          mode = { 'n' },
          nowait = true,
          remap = false,
          -- CoC diagnostic navigation
          { '[d', '<Plug>(coc-diagnostic-prev)', desc = 'Previous diagnostic' },
          { ']d', '<Plug>(coc-diagnostic-next)', desc = 'Next diagnostic' },
          { '<space>e', '<Plug>(coc-diagnostic-info)', desc = 'Manage extensions' },
          -- GoTo commands
          { 'gd', '<Plug>(coc-definition)', desc = 'Go to definition' },
          { 'gy', '<Plug>(coc-type-definition)', desc = 'Go to type definition' },
          { 'gi', '<Plug>(coc-implementation)', desc = 'Go to implementation' },
          { 'gr', '<Plug>(coc-references)', desc = 'Go to references' },
          -- Documentation
          { 'K', '<CMD>lua _G.show_docs()<CR>', desc = 'Show documentation' },
          -- Coc actions
          { '<leader>cr', '<Plug>(coc-rename)', desc = 'Rename symbol' },
          { '<leader>ca', '<Plug>(coc-codeaction-cursor)', desc = 'Cursor code actions' },
          { '<leader>cs', '<Plug>(coc-codeaction-source)', desc = 'Source code actions' },
          { '<leader>ac', '<Plug>(coc-codeaction)', desc = 'Apply code actions' },
          { '<leader>cq', '<Plug>(coc-fix-current)', desc = 'Fix current issue' },
          { '<leader>cl', '<Plug>(coc-codelens-action)', desc = 'CodeLens action' },
          -- CocList mappings
          { '<space>sd', ':CocList diagnostics<cr>', desc = 'Show diagnostics' },
          { '<space>E', ':CocList extensions<cr>', desc = 'Manage extensions' },
          { '<space>sq', ':CocList commands<cr>', desc = 'Show commands' },
          { '<space>so', ':CocList outline<cr>', desc = 'Document outline' },
          { '<space>sy', ':CocList -I symbols<cr>', desc = 'Workspace symbols' },

          { ']=', '<Plug>(coc-typos-next)', desc = 'Next misspelled word' },
          { '[=', '<Plug>(coc-typos-prev)', desc = 'Previous misspelled word' },
          { '<leader>=', '<Plug>(coc-typos-fix)', desc = 'Fix typo at cursor' },
        },

        -- VISUAL mode mappings
        {
          mode = { 'v' },
          nowait = true,
          remap = false,
          { '<leader>f', '<Plug>(coc-format-selected)', desc = 'Format selected code' },
          { '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', desc = 'Refactor selected' },
        },

        -- INSERT mode mappings
        {
          mode = { 'i' },
          nowait = true,
          remap = false,
          {
            '<TAB>',
            'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
            expr = true,
            desc = 'Autocomplete/Next',
          },
          { '<S-TAB>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"', expr = true, desc = 'Autocomplete/Previous' },
          { '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"', expr = true, desc = 'Confirm autocomplete' },
          { '<C-z>', 'coc#refresh()', expr = true, desc = 'Refresh Coc' },
          { '<C-j>', '<Plug>(coc-snippets-expand-jump)', desc = 'Jump in snippet' },
        },

        -- SCROLLING in float windows
        {
          mode = { 'n', 'i', 'v' },
          nowait = true,
          remap = false,
          { '<C-d>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', expr = true, desc = 'Scroll down' },
          { '<C-u>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', expr = true, desc = 'Scroll up' },
        },

        -- VISUAL + OPERATOR mode mappings for text objects
        {
          mode = { 'x', 'o' },
          nowait = true,
          remap = false,
          { 'if', '<Plug>(coc-funcobj-i)', desc = 'Inner function object' },
          { 'af', '<Plug>(coc-funcobj-a)', desc = 'Around function object' },
          { 'ic', '<Plug>(coc-classobj-i)', desc = 'Inner class object' },
          { 'ac', '<Plug>(coc-classobj-a)', desc = 'Around class object' },
        },

        -- SELECTION RANGE
        {
          mode = { 'n', 'x' },
          nowait = true,
          remap = false,
          { '<C-s>', '<Plug>(coc-range-select)', desc = 'Select range' },
        },
      })
    end,
  },
}

return P
