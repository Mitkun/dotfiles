return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"axelvc/template-string.nvim",
		},
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"tsx",
					"lua",
					"vim",
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
				},

				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true,
				},

				autotag = {
					enable = true,
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>v",
						node_incremental = "<leader>v",
						node_decremental = "<leader>V",
						scope_incremental = false,
					},
				},
			})

			require("template-string").setup({})
		end,
	},
}
