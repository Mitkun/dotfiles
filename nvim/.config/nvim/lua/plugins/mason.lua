return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	config = function()
		-- =========================
		-- MASON SETUP
		-- =========================
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- =========================
		-- AUTO INSTALL TOOLS
		-- =========================
		require("mason-tool-installer").setup({
			ensure_installed = {
				"typescript-language-server",
				"eslint_d",
				"prettierd",
				"lua-language-server",
				"stylua",
				"graphql-language-service-cli",
				"prisma-language-server",
			},
		})

		-- =========================
		-- LSP CONFIG
		-- =========================
		local lspconfig = require("lspconfig")
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = cmp_lsp.default_capabilities(capabilities)

		-- hỗ trợ folding cho nvim-ufo
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- =========================
		-- ON_ATTACH (LEAN & CLEAN)
		-- =========================
		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr, silent = true }

			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
		end

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"graphql",
				"prismals",
			},
			handlers = {
				-- DEFAULT HANDLER
				function(server_name)
					-- bỏ qua tsserver vì bạn dùng typescript-tools riêng
					if server_name == "tsserver" or server_name == "ts_ls" then
						return
					end

					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				-- LUA LS SPECIAL CONFIG
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
				end,
			},
		})
	end,
}
