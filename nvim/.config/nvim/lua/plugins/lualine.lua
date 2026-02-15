return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "everforest",
				globalstatus = true,
				section_separators = "",
				component_separators = "",
			},

			sections = {
				-- Trái: context làm việc
				lualine_a = {},
				lualine_b = {
					{ "branch", icon = "" },
					{ "filename", path = 1 },
				},

				-- Giữa: lỗi / warning
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " " },
					},
				},

				-- Phải: trạng thái
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}

