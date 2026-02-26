return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		local todo = require("todo-comments")

		vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next todo comment" })
		vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })

		vim.keymap.set("n", "<leader>t", "<cmd>TodoQuickFix<cr>", { desc = "Todo list" })
		todo.setup()
	end,
}
