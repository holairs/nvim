-- plugins/lsp/lsp.lua

---------------------------------------------------------------------------------------------------
-----------------------------------------------LSP-------------------------------------------------
---------------------------------------------------------------------------------------------------
--
--                This configuration manages the LSP (Language Server Protocol).
--                No plugin is used to auto-install or manage the LSP servers.
--                The plugin "neovim/nvim-lspconfig" is in use, so it is necessary
--                to manually install and configure each LSP server.
--
--                Default personal LSP:
--
--                              * rust_analyzer -> For Rust
--                              * ts_ls         -> For TypeScript & Javascript
--                              * lua_ls        -> For Lua
--                              * pyright       -> For Python
--
--                If is necessary to install another just add another LSP manual call
--                in the respective space.
--
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")

			-- Mappings and options function when LSP is attached
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- Native LSP mappgings
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition(LSP)" })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Search references (LSP)" })
			end

			-- ts_ls config for TypeScript/JavaScript
			lspconfig.ts_ls.setup({
				on_attach = on_attach,
			})

			-- lua-language-server config
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
							disable = { "undefined-global", "unused-local", "undefined-field" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
				on_init = function(client)
					local path = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
					if string.find(path, "config/nvim") then
						client.config.settings.Lua.diagnostics.disable =
							{ "undefined-global", "unused-local", "undefined-field" }
						client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
					end
				end,
			})

			-- rust_analyzer config
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
			})

			-- pyright config
			require("lspconfig").pyright.setup({
				on_attach = on_attach,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
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
