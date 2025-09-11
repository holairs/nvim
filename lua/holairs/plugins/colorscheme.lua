-- colorscheme.lua
return {
	"rose-pine/neovim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "dark" -- O 'light', dependiendo de tu preferencia
		require("rose-pine").setup({
			dark_variant = "main", -- Puedes cambiar a 'moon' o 'dawn' según prefieras
			extend_background_behind_borders = true,
			enable = {
				terminal = true,
				legacy_highlights = true,
				migrations = true,
			},
			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},
			groups = {
				border = "muted",
				link = "iris",
				panel = "surface",
			},
		})

		vim.cmd.colorscheme("rose-pine")
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = true })
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1f1d2e" })
		vim.api.nvim_set_hl(0, "StatusLineNc", { bg = "#1f1d2e" })
		vim.api.nvim_set_hl(0, "LineNr", { bg = "#1f1d2e" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#1f1d2e", fg = "#c4a7e7" })
	end,
}
