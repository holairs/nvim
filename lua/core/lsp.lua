-- Local variables
local lsp = vim.lsp
local api = vim.api

-- Create cmp / capabilities to attach
-- local has_blink, blink = pcall(require, "blink.cmp")
-- local capabilities = has_blink and blink.get_lsp_capabilities() or lsp.protocol.make_client_capabilities()

lsp.config["lua"] = {
	-- capabilities = capabilities,
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

-- Rust
lsp.config("rust", {
	-- capabilities = capabilities,
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	handlers = {
		-- Disable rust-analyzer notifications
		["window/logMessage"] = function() end,
		["window/showMessage"] = function() end,
	},
})

-- Python
lsp.config("basedpyright", {
	-- capabilities = capabilities,
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
})

-- TypeScript / JavaScript (vtsls)
lsp.config("vtsls", {
	-- capabilities = capabilities,
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	settings = {
		vtsls = {
			typescript = {
				updateImportsOnFileMove = { enabled = "always" },
			},
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
	},
})

-- Python (Basedpyright)
lsp.config("basedpyright", {
	-- capabilities = capabilities,
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		basedpyright = {
			analysis = {
				-- 'none', 'warning', 'error', 'information'
				typeCheckingMode = "basic", -- Use 'standard' o 'strict' based on case
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

-- html
lsp.config("html", {
	-- capabilities = capabilities,
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { ".git", "index.html", "package.json" },
	single_file_support = true,
	ettings = {
		html = {
			format = {
				templating = true,
				wrapLineLength = 120,
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
	},
})

-- Enable all lsp
lsp.enable({ "lua", "rust", "basedpyright", "vtsls", "html" })

-- Autocommand to Run lsp on demmand
api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		-- NOTE: Disable Semantic Tokens
		-- local lsp_groups = vim.fn.getcompletion("@lsp", "highlight")
		-- for _, group in ipairs(lsp_groups) do
		--   api.nvim_set_hl(0, group, {})
		-- end
	end,
})
