---@type LazyPluginSpec
local P = {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@type ibl.config
  opts = {
  },
  config = function(_, opts)
    require('ibl').setup(opts)

    -- vim.opt.list = true
    vim.opt.listchars:append('space:⋅')
    vim.opt.listchars:append('eol:↴')
    vim.opt.listchars:append('trail:~')
    vim.opt.listchars:append('nbsp:⍽')
  end,
}

return P
