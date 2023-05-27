return {
  "lambdalisue/fern.vim",
  dependencies = {
    "lambdalisue/fern-hijack.vim",
    "lambdalisue/fern-git-status.vim",
    "lambdalisue/fern-renderer-nerdfont.vim",
    "lambdalisue/nerdfont.vim"
  },
  config = function()
    vim.g["fern#renderer"] = "nerdfont"
  end,
}
