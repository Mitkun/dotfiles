return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		-- 🔍 PICKER (Tìm kiếm file, grep...)
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

		-- Các tính năng bổ trợ giao diện cực hay của Snacks
		indent = { enabled = true }, -- Hiển thị đường kẻ thụt lề
		words = { enabled = true }, -- Highlight các từ giống nhau khi đặt con trỏ
		scope = { enabled = true }, -- Hiển thị phạm vi code hiện tại (function/if/loop)
		scroll = { enabled = true }, -- Cuộn mượt mà
		bigfile = { enabled = true }, -- Tối ưu khi mở file cực lớn
		notifier = { enabled = true }, -- Thông báo (notification) kiểu hiện đại
		input = { enabled = true }, -- Giao diện nhập liệu (rename, v.v.) đẹp hơn
	},

	config = function(_, opts)
		require("snacks").setup(opts)
	end,

	keys = {
		-- 📂 FILES (Tìm file nhanh)
		{
			"<leader>ff",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find files",
		},

		-- 🔎 GREP (Tìm chữ trong toàn bộ dự án)
		{
			"<leader>fg",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Live grep",
		},

		-- 📚 BUFFERS (Danh sách các file đang mở)
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

		-- 🕒 RECENT FILES (File mới mở gần đây)
		{
			"<leader>fr",
			function()
				require("snacks").picker.recent()
			end,
			desc = "Recent files",
		},
	},
}
