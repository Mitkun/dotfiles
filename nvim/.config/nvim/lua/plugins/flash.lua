return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				local flash = require("flash")
				flash.jump()
			end,
			desc = "Flash jump",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				local flash = require("flash")
				flash.treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}

