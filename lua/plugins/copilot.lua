---@type LazyPluginSpec
local P = {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup({
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<C-g>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    })

    vim.g.copilot_no_tab_map = true
    vim.api.nvim_create_user_command('CopilotProxyToggle', function(_)
      if vim.g.copilot_proxy then
        vim.g.copilot_proxy = nil
      else
        vim.g.copilot_proxy = '127.0.0.1:12334'
      end
    end, { desc = 'Toggle proxy for Copilot' })
  end,
}

return P
