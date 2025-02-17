-- Configuration for "highlight colors"
return {
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufRead",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "virtual",
				virtual_symbol = "■",
				virtual_symbol_prefix = "",
				virtual_symbol_suffix = " ",
				virtual_symbol_position = "inline",
				enable_hex = true,
				enable_short_hex = true,
				enable_rg = true,
				enable_hsl = true,
				enable_var_usage = true,
				enable_named_colors = true,
				enable_tailwind = false,
				exclude_filetypes = {},
				exclude_buftypes = {},
			})
		end,
	},
}
