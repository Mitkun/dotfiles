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
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

	vim.keymap.set("n", "gd", function()
		local client = vim.lsp.get_clients({ bufnr = 0 })[1]
		local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

		vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
			if err or not result or vim.tbl_isempty(result) then
				return
			end

			-- Nếu chỉ có 1 result → nhảy thẳng
			if not vim.tbl_islist(result) then
				result = { result }
			end

			if #result == 1 then
				vim.lsp.util.jump_to_location(result[1], client.offset_encoding)
			else
				-- Nhiều hơn 1 → mở popup
				require("snacks").picker.lsp_definitions({
					focus = "list",
					start_in_insert = false,
				})
			end
		end)
	end, opts)

	vim.keymap.set("n", "gr", function()
		local client = vim.lsp.get_clients({ bufnr = 0 })[1]
		local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
		params.context = { includeDeclaration = false }

		vim.lsp.buf_request(0, "textDocument/references", params, function(err, result)
			if err then
				vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
				return
			end

			if not result or vim.tbl_isempty(result) then
				vim.notify("No references found", vim.log.levels.INFO)
				return
			end

			if #result == 1 then
				vim.lsp.util.jump_to_location(result[1], client.offset_encoding)
			else
				require("snacks").picker.lsp_references({
					focus = "list",
					start_in_insert = false,
				})
			end
		end)
	end, opts)
end

-- Cấu hình giao diện popup mặc định (Bo tròn cho đẹp)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

return M
