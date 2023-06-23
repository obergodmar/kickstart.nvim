return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim"
	},
	config = function()
		local dap = require('dap')
		local dapui = require('dapui')
		local dap_virtual_text = require("nvim-dap-virtual-text")

		dapui.setup()
		dap_virtual_text.setup({
			all_references = true,
			virt_text_pos = 'eol'
		})

		dap.adapters.php = {
			type = 'executable',
			command = 'node',
			args = { '/Users/v.kogogin/.cache/vscode-php-debug/out/phpDebug.js' }
		}

		dap.configurations.php = {
			{
				type = 'php',
				request = 'launch',
				name = 'Listen for Xdebug',
				hostName = "127.0.0.1",
				port = 9000,
				serverSourceRoot = '/var/kphp/vkogogin/data/',
				localSourceRoot = '/Users/v.kogogin/Code/vkcom/',
			}
		}

		vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = '[D]ap Toggle Breakpoint' })
		vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { desc = '[D]ap [C]ontinue' })
		vim.api.nvim_set_keymap("n", "<leader>de", ":lua require('dapui').eval()<CR>", { desc = '[D]ap [E]val' })
	end
}
