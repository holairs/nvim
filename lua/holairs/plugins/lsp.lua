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
--                   * ts_ls         -> For TypeScript & Javascript
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
		dependencies = {
			"hrsh7th/nvim-cmp", -- Core autocompletion plugin
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-path", -- File path completions
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp = require("cmp")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Mappings and options function when LSP is attached
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- Native LSP mappgings
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
					buffer = bufnr,
					desc = "Go to definition(LSP)",
				})
				vim.keymap.set("n", "gr", vim.lsp.buf.references, {
					buffer = bufnr,
					desc = "Search references (LSP)",
				})
			end

			-------------------------------------------------------------------------------
			-------------------------------------------------------------------------------
			--                 Manual LSP server setup for each language                 --
			-------------------------------------------------------------------------------
			-------------------------------------------------------------------------------

			-- ts_ls config for TypeScript/JavaScript
			lspconfig.ts_ls.setup({
				on_attach = on_attach,
			})

			-- lua-language-server config
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the ⁠ vim ⁠ global
							globals = {
								"vim",
								"require",
								"opts",
								"bufnr",
								"_value",
							},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- rust_analyzer config
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("Cargo.toml", ".git"),
			})

			-------------------------------------------------------------------------------
			-------------------------------------------------------------------------------
			--                              nvim-cmp setup                               --
			-------------------------------------------------------------------------------
			-------------------------------------------------------------------------------

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(), -- Trigger autocompletion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
					["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" }, -- LSP completions
					{ name = "path" }, -- Path completions
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
			-- Reference preview in Quick Fix List
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "qf",
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
					vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
					vim.keymap.set("n", "<CR>", ":bdelete<CR>", opts)
				end,
			})
		end,
	},
}
