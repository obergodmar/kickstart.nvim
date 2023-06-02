return {
	"glepnir/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				respect_root = true,
			}
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-treesitter/nvim-treesitter" }
	}
}
