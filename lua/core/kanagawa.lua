---@type LazyPluginSpec
local P = {
  -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  'obergodmar/kanagawa.nvim',
  opts = {
    theme = 'wave',
    keywordStyle = { italic = true },
    commentStyle = { italic = true },
  },
  init = function()
    vim.cmd.colorscheme('kanagawa')

    vim.api.nvim_create_user_command('KanagawaDark', function()
      vim.cmd.colorscheme('kanagawa-wave')
    end, { desc = 'Tunr on KanagawaDark theme' })

    vim.api.nvim_create_user_command('KanagawaLight', function()
      vim.cmd.colorscheme('kanagawa-lotus')
    end, { desc = 'Tunr on KanagawaLight theme' })
  end,
}

return P
