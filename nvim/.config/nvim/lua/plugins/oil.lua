return {
	"stevearc/oil.nvim",
	dependencies = {
		{
			"echasnovski/mini.icons",
			opts = { style = "glyphs" },
		},
	},
	lazy = false,
	config = function()
		require("oil").setup({
			use_default_keymaps = false, -- Tắt phím mặc định để dùng bộ map tự định nghĩa bên dưới
			delete_to_trash = true, -- Xóa file sẽ bay vào Thùng rác (Trash) của macOS
			float = {
				padding = 2,
				max_width = 90,
				max_height = 0,
				win_options = {
					winblend = 0, -- Độ trong suốt của cửa sổ nổi (0 là đặc)
				},
			},
		})

		-- Bộ phím tắt chi tiết bên trong buffer Oil (Chỉ có tác dụng khi đang mở Oil)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "oil",
			callback = function()
				local oil_actions = require("oil.actions")
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = true, noremap = true, silent = true, desc = desc })
				end

				-- THOÁT NHANH
				map("q", oil_actions.close.callback, "Đóng Oil và quay lại code")

				-- THAO TÁC FILE
				map("<CR>", oil_actions.select.callback, "Mở file/thư mục")
				map("-", oil_actions.parent.callback, "Quay lại thư mục cha")
				map("R", oil_actions.refresh.callback, "Làm mới danh sách file")
				map("H", oil_actions.toggle_hidden.callback, "Ẩn/Hiện file ẩn (dotfiles)")
				map("gx", oil_actions.open_external.callback, "Mở bằng ứng dụng ngoài (macOS)")

				-- XEM TRƯỚC VÀ TAB
				map("<C-p>", function()
					oil_actions.preview.callback({ vertical = true, split = "rightbelow" })
				end, "Xem nhanh nội dung file bên phải")
				map("<C-t>", function()
					oil_actions.select.callback({ tab = true })
				end, "Mở file trong Tab mới")

				-- DI CHUYỂN VÀ SẮP XẾP
				map("_", oil_actions.open_cwd.callback, "Mở thư mục làm việc hiện tại")
				map("`", oil_actions.cd.callback, "Thay đổi thư mục làm việc (cd)")
				map("gs", oil_actions.change_sort.callback, "Thay đổi cách sắp xếp file")
				map("g\\", oil_actions.toggle_trash.callback, "Xem các file trong Thùng rác")

				-- HƯỚNG DẪN
				map("g?", oil_actions.show_help.callback, "Hiện bảng trợ giúp phím tắt")
			end,
		})

		-- CÁC PHÍM TẮT ĐIỀU KHIỂN BÊN NGOÀI (Dùng Leader)
		vim.keymap.set("n", "<leader>vv", require("oil").open, { desc = "Mở Oil toàn màn hình" })
		vim.keymap.set("n", "<leader>vf", require("oil").open_float, { desc = "Mở Oil cửa sổ nổi" })

		-- TÍNH NĂNG "SOI" THÔNG TIN FILE (Oil Entry Info)
		vim.keymap.set("n", "<leader>vi", function()
			local oil = require("oil")
			local entry = oil.get_cursor_entry()
			local dir = oil.get_current_dir()

			if entry and dir then
				local full_path = vim.fn.fnamemodify(dir .. entry.name, ":p")
				local stat = vim.loop.fs_stat(full_path)

				if stat then
					vim.notify(
						vim.inspect({
							name = entry.name,
							type = entry.type,
							full_path = full_path,
							size = math.floor(stat.size / 1024) .. " KB",
							mode = string.format("%o", stat.mode),
							modified = os.date("%c", stat.mtime.sec),
						}),
						vim.log.levels.INFO,
						{ title = "Thông tin File" }
					)
				else
					vim.notify("Không thể lấy thông tin file", vim.log.levels.WARN)
				end
			else
				vim.notify("Không có file nào dưới con trỏ", vim.log.levels.WARN)
			end
		end, { desc = "Xem chi tiết thuộc tính file" })
	end,
}
