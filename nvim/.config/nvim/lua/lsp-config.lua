local M = {}

-- Capabilities chuẩn
M.capabilities = function()
	local cmp_lsp = require("cmp_nvim_lsp")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	return cmp_lsp.default_capabilities(capabilities)
end

-- On Attach chuẩn
M.on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }

	-- Các phím tắt LSP cơ bản
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", function()
		require("telescope.builtin").lsp_references()
	end, opts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
end

-- Cấu hình giao diện popup mặc định (Bo tròn cho đẹp)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

return M
