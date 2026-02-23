vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

local orig_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}

	-- ===== VSCode style sizing =====
	opts.border = "rounded"
	opts.max_width = 80
	opts.max_height = 20
	opts.wrap = true
	opts.focusable = true

	local bufnr, winid = orig_open_floating_preview(contents, syntax, opts, ...)

	-- Enable line wrapping inside popup
	if bufnr then
		vim.api.nvim_buf_set_option(bufnr, "wrap", true)
	end

	return bufnr, winid
end
vim.opt.rtp:prepend(lazypath)

require("base")
require("keymap")
require("lazy").setup("plugins")
