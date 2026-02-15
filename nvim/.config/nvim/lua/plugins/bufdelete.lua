return {
	"famiu/bufdelete.nvim",
	lazy = true,
	keys = {
		{
			"<leader>bd",
			function()
				require("bufdelete").bufdelete(0, true)
			end,
			desc = "Delete buffer (keep window)",
		},
	},
}

