return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Oil",
	keys = {
		{ "-", "<cmd>Oil --float<CR>", desc = "Open parent directory (Oil)" },
	},

	config = function()
		local oil = require("oil")
		local actions = require("oil.actions")

		oil.setup({
			default_file_explorer = true,

			view_options = {
				show_hidden = true,
			},

			keymaps = {
				["<CR>"] = actions.select,
				["-"] = actions.parent,
				["_"] = actions.open_cwd,
				["q"] = actions.close,
			},

			float = {
				padding = 2,
				max_width = 80,
				max_height = 25,
				border = "rounded",
			},
		})
	end,
}
