return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = true,
			theme = 'dracula',
			component_separators = '|',
			section_separators = '',
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = { 'filename', 'filesize' },
			lualine_x = { 'encoding', 'fileformat', 'filetype' },
			lualine_y = { 'selectioncount', 'searchcount', 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = { {
				'windows',
				mode = 1,
				use_mode_colors = true,
				show_modified_status = true
			} },
			lualine_b = {},
			lualine_c = { 'filename', 'filesize' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	},
}
