return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	config = function()
		-- =========================
		-- REQUIRE SHARED LSP CONFIG
		-- =========================
		local lsp_shared = require("lsp-config")
		local capabilities = lsp_shared.capabilities()
		local on_attach = lsp_shared.on_attach

		local lspconfig = require("lspconfig")

		-- =========================
		-- MASON UI
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
				"eslint_d",
				"prettierd",
				"lua-language-server",
				"stylua",
				"graphql-language-service-cli",
				"prisma-language-server",
			},
		})

		-- =========================
		-- LSP SETUP
		-- =========================
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"graphql",
				"prismals",
			},
			automatic_installation = false,
			handlers = {
				function(server_name)
					-- 🚫 Do NOT setup ts_ls (we use typescript-tools)
					if server_name == "ts_ls" then
						return
					end

					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

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
