return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				graphql = { "prettierd" },
			},

			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype

				-- Kiểm tra cho cả javascript và typescript vì dự án của bạn dùng cả hai
				if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" then
					-- 1. Tự động thêm các import bị thiếu (Giải quyết việc "quên")
					vim.cmd("silent! TSToolsAddMissingImports sync")

					-- 2. Sắp xếp lại và xóa import thừa
					vim.cmd("silent! TSToolsOrganizeImports sync")

					-- 3. (Tùy chọn) Sửa các lỗi nhỏ khác như dấu chấm phẩy, v.v.
					-- vim.cmd("silent! TSToolsFixAll sync")
				end

				return {
					timeout_ms = 1000, -- Tăng lên 1s vì chạy 2 lệnh đồng bộ cần thêm chút thời gian
					lsp_fallback = true, -- Nên để true để nếu LSP lỗi thì Prettier vẫn chạy được
				}
			end,
		})
	end,
}
