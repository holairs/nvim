return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	lazy = false, -- Queremos que cargue al inicio
	priority = 1000, -- Prioridad alta para que cargue antes que otros plugins
	config = function()
		vim.cmd([[colorscheme moonfly]])
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = false })
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
		vim.api.nvim_set_hl(0, "Float", { bg = "none" })
	end,
}
