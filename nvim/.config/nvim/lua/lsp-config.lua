local M = {}

-- Capabilities chuẩn
M.capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- nvim-cmp
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	-- Hỗ trợ folding
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	return capabilities
end

-- On Attach chuẩn
M.on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, silent = true }

	-- ============================================================
	-- 1. CÁC PHÍM TẮT LSP (GIỮ NGUYÊN CỦA BẠN)
	-- ============================================================
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

	vim.keymap.set("n", "gi", function()
		require("snacks").picker.lsp_implementations()
	end, opts)
	vim.keymap.set("n", "gy", function()
		require("snacks").picker.lsp_type_definitions()
	end, opts)

	vim.keymap.set("n", "gd", function()
		local active_clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/definition" })
		if #active_clients == 0 then
			return
		end
		local client_def = active_clients[1]
		local params = vim.lsp.util.make_position_params(0, client_def.offset_encoding)

		vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
			if err or not result or vim.tbl_isempty(result) then
				return
			end
			if not vim.tbl_islist(result) then
				result = { result }
			end
			if #result == 1 then
				vim.lsp.util.jump_to_location(result[1], client_def.offset_encoding)
			else
				require("snacks").picker.lsp_definitions({ focus = "list", start_in_insert = false })
			end
		end)
	end, opts)

	vim.keymap.set("n", "gr", function()
		local active_clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/definition" })
		if #active_clients == 0 then
			return
		end
		local client_ref = active_clients[1]
		local params = vim.lsp.util.make_position_params(0, client_ref.offset_encoding)
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
				vim.lsp.util.jump_to_location(result[1], client_ref.offset_encoding)
			else
				require("snacks").picker.lsp_references({ focus = "list", start_in_insert = false })
			end
		end)
	end, opts)

	-- ============================================================
	-- 2. LOGIC HIGHLIGHT BIẾN/COMPONENT KHI ĐẶT CON TRỎ
	-- ============================================================
	if client and client.server_capabilities.documentHighlightProvider then
		local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

-- ============================================================
-- 3. CẤU HÌNH GIAO DIỆN VÀ MÀU SẮC
-- ============================================================

-- Popup bo tròn
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Cấu hình Diagnostic (Lỗi/Cảnh báo)
vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
		hl_mode = "combine",
	},
	float = {
		border = "rounded",
		source = true,
	},
	severity_sort = true,
	update_in_insert = false,
})

-- Thiết lập màu sắc (Highlight Groups)
local set_hl = vim.api.nvim_set_hl

-- Nền đỏ cho lỗi, nền vàng cho cảnh báo (Virtual Text)
set_hl(0, "DiagnosticVirtualTextError", { fg = "#e67e80", bg = "#3d2b2b", bold = true })
set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#dbbc7f", bg = "#332e22", bold = true })
set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#e67e80" })

-- Nền cho biến được chọn (Document Highlight)
set_hl(0, "LspReferenceText", { bg = "#3d484d", underline = true, sp = "#e67e80" })
set_hl(0, "LspReferenceRead", { bg = "#3d484d", underline = true, sp = "#e67e80" })
set_hl(0, "LspReferenceWrite", { bg = "#4b565c", bold = true, underline = true, sp = "#e67e80" })

return M
