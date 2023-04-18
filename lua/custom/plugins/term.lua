return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		-- local powershell_options = {
		-- 	shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
		-- 	shellcmdflag =
		-- 	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		-- 	shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		-- 	shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		-- 	shellquote = "",
		-- 	shellxquote = "",
		-- }

		-- if vim.fn.has("win32") == 1 then
		-- 	for option, value in pairs(powershell_options) do
		-- 		vim.opt[option] = value
		-- 	end
		-- end

		local function get_shell()
			if vim.fn.has("win32") == 1 then
				return vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
			end

			return vim.shell
		end

		--
		require('toggleterm').setup {
			shade_terminals = false,
			start_in_insert = true,
			open_mapping = [[<c-\>]],
			shell = get_shell(),
		}
	end
}
