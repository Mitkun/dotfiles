return {
	"stevanmilic/nvim-lspimport",
	config = function()
		-- Gán phím tắt ai (Auto Import)
		vim.keymap.set("n", "<leader>ai", function()
			require("lspimport").import()
		end, { desc = "LSP Import (Manual)" })
	end,
}
