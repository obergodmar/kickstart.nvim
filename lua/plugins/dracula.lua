return {
  "Mofiqul/dracula.nvim",
  priority = 1000,
  config = function()
    local dracula = require("dracula")
    local colors = dracula.colors()

    vim.cmd.colorscheme("dracula")
    vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = colors.comment })

    dracula.setup({
      show_end_of_buffer = true,
      italic_comment = true,
      lualine_bg_color = "#44475a",
    })
  end,
}
