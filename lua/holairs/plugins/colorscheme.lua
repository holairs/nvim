return {
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			vim.opt.background = "dark"
			vim.cmd("colorscheme zenbones")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = true })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#352f2d" })
			vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4bdc3", bg = "#352f2d" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		end,
	},
}
