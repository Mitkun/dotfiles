return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- dùng Treesitter để thông minh hơn
			enable_check_bracket_line = true,
			ignored_next_char = "[%w%.]", -- không auto nếu sau đó là chữ
			fast_wrap = {},
		})

		-- =============================
		-- INTEGRATION WITH NVIM-CMP
		-- =============================

		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
