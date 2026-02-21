return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lsp_shared = require("lsp-config")

		require("typescript-tools").setup({
			capabilities = lsp_shared.capabilities(),
			on_attach = lsp_shared.on_attach,
			settings = {
				tsserver_file_preferences = {
					importModuleSpecifierPreference = "non-relative",
					includeCompletionsForModuleExports = true,
					includeCompletionsForImportStatements = true,
				},
			},
		})
	end,
}
