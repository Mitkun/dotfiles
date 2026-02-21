return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				graphql = { "prettierd" },
			},

			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype

				if ft == "typescript" or ft == "typescriptreact" then
					vim.cmd("TSToolsOrganizeImports sync")
				end

				return {
					timeout_ms = 500,
					lsp_fallback = false,
				}
			end,
		})
	end,
}
