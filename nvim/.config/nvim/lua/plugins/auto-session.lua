return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		require("auto-session").setup({
			auto_restore_enabled = true,
			auto_restore_last_session = true,
			auto_save_enabled = true,
			log_level = "error",
			suppressed_dirs = { "~/" },
		})
	end,
}
