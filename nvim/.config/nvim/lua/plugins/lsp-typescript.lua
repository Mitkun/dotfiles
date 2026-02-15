return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local api = require("typescript-tools.api")

		require("typescript-tools").setup({
			handlers = {
				["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 6133 }),
			},
			settings = {
				tsserver_file_preferences = {
					importModuleSpecifierPreference = "non-relative",
				},
				-- Tự động thêm semicolon, v.v. nếu bạn muốn
				tsserver_format_options = {
					insertSpaceAfterCommaDelimiter = true,
				},
			},
		})
	end,
}
