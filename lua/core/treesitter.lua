---@type LazyPluginSpec
local P = {
  -- Nvim Treesitter configurations and abstraction layer
  'obergodmar/nvim-treesitter',
  dependencies = {
    'obergodmar/nvim-treesitter-context',
  },
  branch = 'master',
  config = function()
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))

    require('nvim-treesitter.configs').setup({
      additional_vim_regex_highlighting = false,
      modules = {},
      ignore_install = {},
      sync_install = true,
      ensure_installed = {
        'markdown',
        'markdown_inline',
        'regex',
        'lua',
        'vim',
        'bash',
        'comment',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

return P
