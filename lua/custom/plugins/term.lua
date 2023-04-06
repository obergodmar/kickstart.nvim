return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		require('toggleterm').setup {
			shade_terminals = false,
			start_in_insert = true,
			open_mapping = [[<c-\>]],
		}
	end
}
