return {
	"Mofiqul/dracula.nvim",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "dracula"

		local dracula = require('dracula')
		dracula.setup({
			show_end_of_buffer = true,
			italic_comment = true,
			lualine_bg_color = "#44475a",
		})
	end
}
