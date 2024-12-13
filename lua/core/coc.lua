---@type LazyPluginSpec
local P = {
  'neoclide/coc.nvim',
  branch = 'master',
  enabled = true,
  build = 'npm ci & npm run build',
  config = function()
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
}

return P
