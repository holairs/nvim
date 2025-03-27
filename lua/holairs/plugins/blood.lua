return {
	'sainttttt/flesh-and-blood',
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme flesh-and-blood")
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = true })
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
	end,
}
