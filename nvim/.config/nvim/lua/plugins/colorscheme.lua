return {
	"sainnhe/everforest",
	priority = 1000,
	config = function()
		-- =============================
		-- EVERFOREST SETTINGS
		-- =============================

		vim.g.everforest_transparent_background = 2
		vim.g.everforest_diagnostic_line_highlight = 1

		vim.cmd([[colorscheme everforest]])

		-- =============================
		-- TRUE TRANSPARENCY
		-- =============================

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

		-- =============================
		-- FLOAT / POPUP
		-- =============================

		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#232a2e", blend = 10 })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#e6c384", bg = "#232a2e" })
		vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#e6c384", bold = true })

		-- =============================
		-- Completion (nvim-cmp)
		-- =============================

		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#232a2e", blend = 10 })
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3c484f", bold = true })
		vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#e6c384", bg = "#232a2e" })

		-- =============================
		-- Telescope
		-- =============================

		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#232a2e", blend = 10 })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#e6c384", bg = "#232a2e" })
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#3c484f", bold = true })
	end,
}
