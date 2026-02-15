return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				diagnostics = "nvim_lsp",
				separator_style = "slant",
				show_buffer_close_icons = true,
				show_close_icon = false,
				always_show_bufferline = true,
			},

			highlights = {
				-- buffer đang focus
				buffer_selected = {
					fg = "#e6c384",
					bold = true,
					italic = false,
				},

				tab_selected = {
					fg = "#e6c384",
					bold = true,
				},

				indicator_selected = {
					fg = "#e6c384",
				},

				-- buffer đang mở nhưng không focus
				buffer_visible = {
					fg = "#a7c080",
				},

				-- buffer không focus
				background = {
					fg = "#5c6a72",
				},

				-- separator mờ hơn khi không focus
				separator = {
					fg = "#3c484f",
				},
			},
		})

		vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
	end,
}
