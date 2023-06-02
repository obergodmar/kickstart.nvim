return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require('trouble').setup({
			padding = false,
			action_keys = {
				close = "q",                  -- close the list
				cancel = "<esc>",             -- cancel the preview and get back to your last window / buffer / cursor
				refresh = "r",                -- manually refresh
				jump_close = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
				open_split = { "<c-x>" },     -- open buffer in new split
				open_vsplit = { "<c-v>" },    -- open buffer in new vsplit
				open_tab = { "<c-t>" },       -- open buffer in new tab
				jump = { "o" },               -- jump to the diagnostic and close the list
				toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
				switch_severity = "s",        -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
				toggle_preview = "P",         -- toggle auto_preview
				hover = "K",                  -- opens a small popup with the full multiline message
				preview = "p",                -- preview the diagnostic location
				close_folds = { "zM", "zm" }, -- close all folds
				open_folds = { "zR", "zr" },  -- open all folds
				toggle_fold = { "zA", "za" }, -- toggle fold of current file
				previous = "k",               -- previous item
				next = "j"                    -- next item
			}
		})
	end
}
