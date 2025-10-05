return {
	"andreasvc/vim-256noir",

	config = function()
		vim.cmd("colorscheme 256_noir")
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = false })
	end,
}
