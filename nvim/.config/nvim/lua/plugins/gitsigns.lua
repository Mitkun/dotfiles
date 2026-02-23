return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local gs = require("gitsigns")

		gs.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "▁" },
				topdelete = { text = "▔" },
				changedelete = { text = "~" },
			},

			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,

			watch_gitdir = {
				follow_files = true,
			},

			attach_to_untracked = true,

			current_line_blame = true,
			current_line_blame_opts = {
				delay = 800,
				virt_text_pos = "eol",
			},

			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
			},

			on_attach = function(bufnr)
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- =========================================
				-- Navigation (diff-safe)
				-- =========================================
				map("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, "Next Hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, "Prev Hunk")

				-- =========================================
				-- Stage / Reset
				-- =========================================
				map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")

				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage Selection")

				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Selection")

				map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")

				-- =========================================
				-- Preview / Blame
				-- =========================================
				map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>hb", gs.blame_line, "Blame Line")

				-- =========================================
				-- Smart Diff Toggle (NO EMPTY WINDOW)
				-- =========================================
				map("n", "<leader>hd", function()
					if vim.wo.diff then
						vim.cmd("diffoff!")
						vim.cmd("only") -- đóng split dư
					else
						gs.diffthis()
					end
				end, "Toggle Diff")

				map("n", "<leader>hD", function()
					if vim.wo.diff then
						vim.cmd("diffoff!")
						vim.cmd("only")
					else
						gs.diffthis("~")
					end
				end, "Toggle Diff Against Last Commit")

				-- =========================================
				-- Text object (very powerful)
				-- =========================================
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
			end,
		})
	end,
}
