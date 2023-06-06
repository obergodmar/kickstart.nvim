return {
	"Mofiqul/dracula.nvim",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "dracula"

		local dracula = require('dracula')
		dracula.setup({})
	end
}
