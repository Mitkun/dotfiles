return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},

			current_line_blame = false, -- bật nếu muốn auto blame
		})

		-- Keymap
		local gs = require("gitsigns")

		vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next git hunk" })
		vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev git hunk" })

		vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
		vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
		vim.keymap.set("n", "<leader>hd", gs.preview_hunk, { desc = "Preview hunk" })
	end,
}
