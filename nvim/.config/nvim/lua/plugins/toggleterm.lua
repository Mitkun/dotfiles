return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			direction = "horizontal",
			shade_terminals = false,
		})

		-- =============================
		-- KEYMAPS
		-- =============================

		-- Terminal 1 (server)
		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm 1<CR>", { desc = "Terminal 1" })
		vim.keymap.set("t", "<leader>tt", [[<C-\><C-n><cmd>ToggleTerm 1<CR>]], { desc = "Terminal 1" })

		-- Terminal 2 (git)
		vim.keymap.set("n", "<leader>tg", "<cmd>ToggleTerm 2<CR>", { desc = "Terminal 2" })
		vim.keymap.set("t", "<leader>tg", [[<C-\><C-n><cmd>ToggleTerm 2<CR>]], { desc = "Terminal 2" })

		-- Esc về normal trong terminal
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

		-- =============================
		-- PROTECT TERMINAL WINDOW
		-- =============================

		-- Nếu đang ở terminal mà người dùng đổi buffer
		-- thì tự động nhảy lên window phía trên
		vim.api.nvim_create_autocmd("BufLeave", {
			callback = function(args)
				local bufnr = args.buf

				-- Chỉ xử lý nếu là terminal
				if vim.bo[bufnr].buftype == "terminal" then
					-- Nếu còn window khác thì chuyển lên trên
					if #vim.api.nvim_list_wins() > 1 then
						vim.cmd("wincmd k")
					end
				end
			end,
		})
	end,
}
