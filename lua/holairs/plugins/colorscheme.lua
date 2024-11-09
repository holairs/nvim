-- plugins/colorscheme.lua

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------                        Moonfly, nice retro and pastel colors                       --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- return {
-- 	"bluz71/vim-moonfly-colors",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme moonfly")
-- 		-- Colorscheme options
-- 		-- Make the background of the current line number transparent and change its color to orange
-- 		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#b46958", bg = "#323437", bold = true })
--
-- 		-- Make the line number column have the same gray color as the status line
-- 		vim.api.nvim_set_hl(0, "LineNr", { fg = "#b2ceee", bg = "#323437" })
--
--     -- Tabline colors
-- 		vim.api.nvim_set_hl(0, "TabLine", { fg = "#b2ceee", bg = "#323437" })
-- 		vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#b2ceee", bg = "#323437" })
--
-- 		-- Ensuring that the sign column is also transparent
-- 		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--
-- 		-- Configure transparency for both normal and non-current backgrounds
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--
-- 		-- set the status line to be gray
-- 		vim.api.nvim_set_hl(0, "statusline", { fg = "#b2ceee", bg = "#323437" })
--
-- 		-- Characters Column color
-- 		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#323437" })
-- 	end,
-- }

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------                   no-clown-fiesta.nvim   Minimal, nice soft colors                 --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

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
		-- Fonts
		vim.api.nvim_set_hl(0, "Comment", { italic = true })
		vim.api.nvim_set_hl(0, "Keyword", { italic = true })
		vim.api.nvim_set_hl(0, "Type", { italic = true })
	end,
}

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------                   zenbones   Minimal, monochromatic colors                         --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- return {
-- 	{
-- 		"mcchrish/zenbones.nvim",
-- 		dependencies = { "rktjmp/lush.nvim" },
-- 		config = function()
-- 			vim.opt.background = "dark"
-- 			vim.cmd("colorscheme zenbones")
-- 			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- 		end,
-- 	},
-- }

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------                       vim-256noir Minimal, monochromatic b&w                       --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- return {
-- 	"andreasvc/vim-256noir",
-- 	config = function()
-- 		vim.opt.background = "dark"
-- 		vim.cmd("colorscheme 256_noir")
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "signcolumn", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "cursorlinenr", { fg = "#FFFFFF", bg = "none", bold = true })
-- 	end,
-- }

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------                   Monochrome Minimal, monochromatic b&w variatons                  --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- return {
-- 	{
-- 		"kdheepak/monochrome.nvim",
-- 		config = function()
-- 			vim.opt.background = "dark"
-- 			vim.cmd("colorscheme monochrome")
-- 			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "signcolumn", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "cursorlinenr", { fg = "#FFFFFF", bg = "none", bold = true })
-- 		end,
-- 	},
-- }

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------                             A lot of colorschemes                                  --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- return {
-- 	"wincent/base16-nvim",
-- 	lazy = false, -- load at start
-- 	priority = 1000, -- load first,
-- 	config = function()
-- 		vim.cmd([[colorscheme base16-gruvbox-dark-soft]])
-- 		vim.o.background = "dark"
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "SignColumn", { bg = "#3c3836" })
--
-- 		-- Asignar el mismo fondo a los signos del LSP en SignColumn
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "#3c3836", fg = "#fb4934" })
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "#3c3836", fg = "#fabd2f" })
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "#3c3836", fg = "#83a598" })
-- 		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "#3c3836", fg = "#8ec07c" })
-- 	end,
-- }
--

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-------                             A blood red scheme color                               --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- return {
-- 	"sainttttt/flesh-and-blood",
-- 	config = function()
-- 		vim.opt.background = "dark"
-- 		vim.cmd("colorscheme flesh-and-blood")
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "signcolumn", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "cursorlinenr", { fg = "#FFFFFF", bg = "none", bold = true })
-- 	end,
-- }

-- return {
-- 	-- Right now using a default colorscheme
-- }
