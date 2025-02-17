return {
	{
		"VidocqH/lsp-lens.nvim",
		event = "BufRead",
		opts = {
			include_declaration = true, -- Reference include declaration
			sections = {             -- Enable / Disable specific request
				definition = false,
				references = true,
				implementation = false,
			},
		},
		keys = {
			{
				-- LspLensToggle
				"<leader>ll",
				"<cmd>LspLensToggle<CR>",
				desc = "LSP Len Toggle",
			},
		},
	},
}
