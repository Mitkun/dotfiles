return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			direction = "horizontal",
			shade_terminals = false,
		})

		-- Terminal 1 (server)
		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm 1<CR>", { desc = "Terminal 1" })
		vim.keymap.set("t", "<leader>tt", [[<C-\><C-n><cmd>ToggleTerm 1<CR>]], { desc = "Terminal 1" })

		-- Terminal 2 (git)
		vim.keymap.set("n", "<leader>tg", "<cmd>ToggleTerm 2<CR>", { desc = "Terminal 2" })
		vim.keymap.set("t", "<leader>tg", [[<C-\><C-n><cmd>ToggleTerm 2<CR>]], { desc = "Terminal 2" })

		-- Esc về normal trong terminal
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })
	end,
}
