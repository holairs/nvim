return {
	{
		"VidocqH/lsp-lens.nvim",
		event = "BufRead",
		opts = {
			include_declaration = true, -- Reference include declaration
			sections = {             -- Enable / Disable specific request
				definition = true,
				references = true,
				implementation = true,
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
