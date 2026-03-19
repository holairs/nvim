return {
	"zenbones-theme/zenbones.nvim",
	dependencies = { "rktjmp/lush.nvim" },
	lazy = false,
	priority = 1000,
	config = function()
		local api = vim.api
		vim.o.background = "dark"
		vim.cmd.colorscheme("zenbones")
		api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = true })
		api.nvim_set_hl(0, "Normal", { bg = "none" })
		api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
		api.nvim_set_hl(0, "Float", { bg = "none" })
		api.nvim_set_hl(0, "StatusLine", { bg = "none" })
	end,
}
