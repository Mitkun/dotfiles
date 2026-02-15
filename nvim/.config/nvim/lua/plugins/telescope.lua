return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					".git",
					"lazy-lock.json",
					"*-lock.yaml",
					"%.lock",
					"codegen.ts",
				},
				dynamic_preview_title = true,
				path_display = { "smart" },
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						preview_cutoff = 120,
						preview_width = 0.5,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})
	end,
}
