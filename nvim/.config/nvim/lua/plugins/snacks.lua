return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {

		-- 🔍 PICKER
		picker = {
			enabled = true,
			layout = {
				preset = "default",
			},
			win = {
				input = {
					border = "rounded",
					keys = {
						["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
					},
				},
				list = {
					border = "rounded",
					keys = {
						["<C-d>"] = "preview_scroll_down",
						["<C-u>"] = "preview_scroll_up",
					},
				},
				preview = {
					border = "rounded",
					focusable = true,
				},
			},
			sources = {
				files = {
					hidden = true,
					ignore = {
						"node_modules",
						".git",
						"lazy-lock.json",
						"%-lock.yaml",
						"%.lock",
						"codegen.ts",
					},
				},
			},
		},

		indent = { enabled = true },
		words = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		bigfile = { enabled = true },
		notifier = { enabled = true },

		-- 🖥 TERMINAL
		terminal = {
			enabled = true,
			shell = "zsh",
			win = {
				position = "bottom",
				height = 0.35,
			},
		},
	},

	config = function(_, opts)
		require("snacks").setup(opts)
		local Terminal = require("snacks.terminal")

		--------------------------------------------------
		-- 🔹 GIỮ NGUYÊN HỆ THỐNG NORMAL MODE CỦA BẠN
		--------------------------------------------------

		local group = vim.api.nvim_create_augroup("SnacksTerminalNormalMode", { clear = true })

		-- Mở terminal → luôn về Normal mode
		vim.api.nvim_create_autocmd("TermOpen", {
			group = group,
			callback = function()
				vim.cmd("stopinsert")
			end,
		})

		-- Focus vào terminal → luôn về Normal mode
		vim.api.nvim_create_autocmd("WinEnter", {
			group = group,
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				if vim.bo[buf].buftype == "terminal" then
					vim.schedule(function()
						vim.cmd("stopinsert")
					end)
				end
			end,
		})

		-- Enter trong terminal → gửi lệnh rồi về Normal mode
		vim.keymap.set("t", "<CR>", [[<CR><C-\><C-n>]], {
			noremap = true,
			silent = true,
		})

		--------------------------------------------------
		-- 🔥 TOGGLE HEIGHT = 0 + FOCUS CONTROL
		--------------------------------------------------

		local panel_height = 0.35
		local hidden = false

		local function get_terminal_wins()
			local wins = vim.api.nvim_list_wins()
			local terms = {}

			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buftype == "terminal" then
					table.insert(terms, win)
				end
			end

			return terms
		end

		local function toggle_terminal_panel()
			local terms = get_terminal_wins()

			-- chưa có terminal → mở mới và focus
			if #terms == 0 then
				Terminal.open()
				hidden = false
				return
			end

			local total_height = vim.o.lines
			local target_height = math.floor(total_height * panel_height)

			if hidden then
				-- 🔹 HIỆN LẠI

				for _, win in ipairs(terms) do
					if vim.api.nvim_win_is_valid(win) then
						vim.api.nvim_win_set_height(win, target_height)
					end
				end

				-- focus vào terminal đầu tiên
				if vim.api.nvim_win_is_valid(terms[1]) then
					vim.api.nvim_set_current_win(terms[1])
				end

				hidden = false
			else
				-- 🔹 ẨN ĐI

				-- nếu đang ở terminal → nhảy ra window trước
				if vim.bo.buftype == "terminal" then
					vim.cmd("wincmd k")
				end

				for _, win in ipairs(terms) do
					if vim.api.nvim_win_is_valid(win) then
						vim.api.nvim_win_set_height(win, 0)
					end
				end

				hidden = true
			end
		end

		vim.keymap.set("n", "<leader>tt", toggle_terminal_panel, { desc = "Toggle Terminal Height" })

		vim.keymap.set("n", "<leader>tn", function()
			Terminal.open()
		end, { desc = "New Terminal" })
	end,

	keys = {

		-- 📂 FILES
		{
			"<leader>ff",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find files",
		},

		-- 🔎 GREP
		{
			"<leader>fg",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Live grep",
		},

		-- 📚 BUFFERS
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers({
					focus = "list",
					start_in_insert = false,
				})
			end,
			desc = "Buffers",
		},
	},
}
