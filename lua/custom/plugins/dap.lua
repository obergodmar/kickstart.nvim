---@type LazyPluginSpec
local P = {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        all_references = true,
        virt_text_pos = 'eol',
      },
    },
    {
      'rcarriga/nvim-dap-ui',
      opts = {},
    },

    'nvim-telescope/telescope-dap.nvim',
  },
  keys = {
    {
      '<leader>db',
      '<cmd>DapToggleBreakpoint<CR>',
      id = 'dap_toggle_breakpoint',
      desc = '[D]ap Toggle Breakpoint',
      mode = 'n',
    },
    {
      '<leader>dc',
      '<cmd>DapContinue<CR>',
      id = 'dap_continue',
      desc = '[D]ap [C]ontinue',
      mode = 'n',
    },
    {
      '<leader>de',
      ":lua require('dapui').eval()<CR>",
      id = 'dapui_eval',
      desc = '[D]ap [E]val',
      mode = 'n',
    },
  },
  config = function()
    local dap = require('dap')

    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { '' },
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        hostName = '127.0.0.1',
        port = 9000,
        serverSourceRoot = '',
        localSourceRoot = '',
      },
    }
  end,
}

return P
