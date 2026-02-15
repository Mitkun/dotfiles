return {
	"sontungexpt/vietnamese.nvim",
	event = "InsertEnter",
	config = function()
		require("vietnamese").setup({
			enabled = true,
			input_method = "vni",
			orthography = "modern",
		})
	end,
}
