return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup {
			sources = {
				null_ls.builtins.formatting.beautysh,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.phpcs,
			},
			on_attach = function(client, bufnr)
			end
		}
	end
}
