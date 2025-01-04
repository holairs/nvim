-- plugins/lsp/lsp.lua

-------------------------------------------------------------------------------
-------------------------------------LSP---------------------------------------
-------------------------------------------------------------------------------
--
--     This configuration manages the LSP (Language Server Protocol).
--     No plugin is used to auto-install or manage the LSP servers.
--     The plugin "neovim/nvim-lspconfig" is in use, so it is necessary
--     to manually install and configure each LSP server.
--
--     Default personal LSP:
--
--                   * rust_analyzer -> For Rust
--                   * ts_ls / vtsls -> For TypeScript & Javascript
--                   * lua_ls        -> For Lua
--
--     If is necessary to install another just add another LSP manual call
--     in the respective space.
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")

			-- Mappings and options function when LSP is attached
			local on_attach = function(client, bufnr)
				-- Native LSP actions mappgings
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
					buffer = bufnr,
					desc = "Go to definition(LSP)",
				})
				vim.keymap.set("n", "gr", vim.lsp.buf.references, {
					buffer = bufnr,
					desc = "Search references (LSP)",
				})
				vim.keymap.set("n", "nd", function()
					vim.cmd("tab split")
					vim.lsp.buf.definition()
				end, {
					buffer = bufnr,
					desc = "Go to definition (LSP) in a new tab",
				})
				vim.keymap.set("n", "nr", function()
					vim.cmd("tab split")
					vim.lsp.buf.references()
				end, {
					buffer = bufnr,
					desc = "Search references (LSP) in a new tab",
				})
			end

			-- Manual LSP servers configuration
			-- TypeScript and JavaScript LSP
			lspconfig.vtsls.setup({
				on_attach = on_attach,
			})

			-- Lua LSP
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = {
								"vim",
								"require",
								"opts",
								"bufnr",
								"_value",
							},
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Rust LSP
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("Cargo.toml", ".git"),
			})
		end,
	},
}
