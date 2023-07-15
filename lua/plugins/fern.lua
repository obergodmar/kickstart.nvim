return {
  "lambdalisue/fern.vim",
  dependencies = {
    "lambdalisue/fern-hijack.vim",
    "lambdalisue/fern-git-status.vim",
    "lambdalisue/fern-renderer-nerdfont.vim",
    "lambdalisue/nerdfont.vim",
  },
  config = function()
    vim.g["fern#renderer"] = "nerdfont"
    vim.api.nvim_set_keymap("n", "<leader>f", ":Fern . -reveal=%<CR>", { desc = "Fern reveal [F]ile" })
  end,
}
