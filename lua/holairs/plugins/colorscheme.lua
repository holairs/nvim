return {
	"aktersnurra/no-clown-fiesta.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		vim.cmd("colorscheme no-clown-fiesta")

		vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#b46958", bg = "#232323" })
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "signcolumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "cursorlinenr", { fg = "#b46958", bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#505050", bg = "none" })
		vim.api.nvim_set_hl(0, "statusline", { bg = "#171717", fg = "#b46958" })
		vim.api.nvim_set_hl(0, "normalfloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "floatborder", { bg = "none" })
		vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })
		vim.api.nvim_set_hl(0, "MsgSeparator", { bg = "none" })
		vim.api.nvim_set_hl(0, "Cmdline", { bg = "none", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "CmdlineWin", { bg = "none", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "CmdlineMode", { bg = "none", ctermbg = "NONE" })
                vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = true })
		vim.api.nvim_set_hl(0, "Comment", { italic = true })
		vim.api.nvim_set_hl(0, "Keyword", { italic = true })
		vim.api.nvim_set_hl(0, "Type", { italic = true })
	end,
}
