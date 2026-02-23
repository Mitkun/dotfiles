return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false, -- README: không hỗ trợ lazy-load

		config = function()
			-- Cài parser (tương đương ensure_installed cũ)
			require("nvim-treesitter").install({
				"tsx",
				"lua",
				"vim",
				"vimdoc",
				"typescript",
				"javascript",
				"html",
				"css",
				"json",
				"graphql",
				"regex",
				"prisma",
				"markdown",
				"markdown_inline",
			})

			-- Bật highlight cho các filetype trên
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"tsx",
					"lua",
					"vim",
					"typescript",
					"javascript",
					"html",
					"css",
					"json",
					"graphql",
					"prisma",
					"markdown",
				},
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}
