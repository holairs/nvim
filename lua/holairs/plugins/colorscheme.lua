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
		end,
	},
}
