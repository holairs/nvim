-- plugins/lsp/lsp.lualsp

-------------------------------------------------------------------------------
------------------------------------- LSP -------------------------------------
-------------------------------------------------------------------------------
--                                                                           --
--  This configuration manages the LSP (Language Server Protocol) and        --
--  integrates it with the "nvim-cmp" plugin for enhanced autocompletion.    --
--                                                                           --
--  Features:                                                                --
--  1. Manual LSP server installation and setup using "neovim/nvim-lspconfig".--
--  2. Predefined key mappings for common LSP actions like "Go to            --
--     Definition" and "Find References".                                    --
--                                                                           --
--  Default personal LSPs:                                                   --
--                                                                           --
--    * rust_analyzer -> For Rust                                            --
--    * ts_ls / vtsls -> For TypeScript & JavaScript                         --
--    * lua_ls        -> For Lua                                             --
--                                                                           --
--  To add another LSP server, configure it manually in the respective       --
--  section below, ensuring it uses the shared `on_attach` and `capabilities`--
--  setup for consistency.                                                   --
--                                                                           --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},

		config = function()
			local lspconfig = require("lspconfig")
			local cmp = require("cmp")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Add LSP capabilities to the completion menu
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

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
				vim.keymap.set("n", "td", function()
					vim.cmd("tab split")
					vim.lsp.buf.definition()
				end, {
					buffer = bufnr,
					desc = "Go to definition (LSP) in a new tab",
				})
				vim.keymap.set("n", "tr", function()
					vim.cmd("tab split")
					vim.lsp.buf.references()
				end, {
					buffer = bufnr,
					desc = "Search references (LSP) in a new tab",
				})

				-- Toggle Inlay Hints
				vim.keymap.set("n", "<Leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
				end, {
					buffer = bufnr,
					desc = "Toggle Inlay Hints (LSP)",
				})
			end

			-- Manual LSP servers configuration

			-- TypeScript and JavaScript LSP
			lspconfig.vtsls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Lua LSP
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
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
								"fs_stat",
								"cwd",
								"utils",
							},
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "space",
								indent_size = "2",
							},
						},
					},
				},
			})

			-- Rust LSP
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("Cargo.toml", ".git"),
			})

			-- Json LSP
			lspconfig.jsonls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Python
			lspconfig.basedpyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Cpp LSP
			lspconfig.clangd.setup({
				init_options = {
					fallbackFlags = {
						"-std=c++11",
					},
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})

			cmp.setup({
				completion = {
					autocomplete = { cmp.TriggerEvent.TextChanged }, -- Autocomplete on type
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-f>"] = cmp.mapping.scroll_docs(5),
					["<C-u>"] = cmp.mapping.scroll_docs(-5),
				},
				sources = {
					{ name = "nvim_lsp" }, -- LSP source
				},
				window = {
					documentation = {
						winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
						scrolloff = 3,
						col_offset = 1,
						max_height = 15,
						max_width = 60,
					},
					completion = {
						scrollbar = true,
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
						scrolloff = 3,
						col_offset = 0,
					},
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
						})[entry.source.name]
						return vim_item
					end,
				},
				experimental = {
					ghost_text = false, -- Shows suggested text as ghost text
				},
			})
		end,
	},

	vim.diagnostic.config({
		virtual_text = {
			spaces = 4,
			prefix = "●",
		},
		float = {
			source = true,
			border = "rounded",
		},
		underline = false,
		update_in_insert = true,
	}),
}
