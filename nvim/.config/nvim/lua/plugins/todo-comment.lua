return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		local todo = require("todo-comments")

		vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next todo comment" })
		vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })

		vim.keymap.set("n", "<leader>t", "<cmd>TodoTelescope<cr>", { desc = "Todo list (Telescope)" })

		todo.setup()
	end,
}
