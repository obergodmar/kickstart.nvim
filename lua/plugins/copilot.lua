---@type LazyPluginSpec
local P = {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  dependencies = {
    { 'github/copilot.vim' },
    { 'nvim-lua/plenary.nvim' },
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  event = 'VeryLazy',
  opts = {
    -- proxy = 'http://127.0.0.1:12334',
    debug = false, -- Enable debugging
    mappings = {
      complete = {
        insert = '',
      },
    },
  },
  keys = {
    {
      '<leader>ccq',
      function()
        local input = vim.fn.input('Quick Chat: ')
        if input ~= '' then
          require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
        end
      end,
      desc = 'CopilotChat - Quick chat',
    },
    {
      '<leader>cch',
      function()
        local actions = require('CopilotChat.actions')
        require('CopilotChat.integrations.fzflua').pick(actions.help_actions())
      end,
      desc = 'CopilotChat - Help actions',
    },
    -- Show prompts actions with fzf-lua
    {
      '<leader>ccp',
      function()
        local actions = require('CopilotChat.actions')
        require('CopilotChat.integrations.fzflua').pick(actions.prompt_actions())
      end,
      desc = 'CopilotChat - Prompt actions',
    },
  },
  config = function(_, opts)
    require('CopilotChat').setup(opts)
    require('CopilotChat.integrations.cmp').setup()

    vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })

    vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_proxy = '127.0.0.1:12334'
  end,
}

return P
