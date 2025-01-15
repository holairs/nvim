-------------------------------------------------------------------------------
--------------------------- Monochrome Colorscheme ----------------------------
-------------------------------------------------------------------------------
--  Name: Monochrome_Light                                                    --
--  Author: Holairs                                                          --
--  A minimalistic colorscheme inspired by shades of gray and monochromatic  --
--  tones, designed for a light background. The palette focuses on subtle    --
--  contrasts and accents, offering a clean and visually appealing           --
--  experience for coding. Each syntax element is highlighted with varying   --
--  shades of gray, complemented by red accents for errors and numbers,      --
--  ensuring readability without distraction.                                --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local M = {}
local set = vim.api.nvim_set_hl
local set_sign = vim.fn.sign_define

function M.setup()
	vim.o.background = "light"
	vim.cmd([[hi clear]])
	if vim.fn.exists("syntax_on") then
		vim.cmd([[syntax reset]])
	end

	vim.g.colors_name = "monochrome_light"

	-- Define colors
	local colors = {
		background = "none", -- Fondo blanco
		white = "#ffffff",
		foreground = "#000000", -- Texto principal en negro
		light_gray = "#757575", -- Gris intermedio para constantes
		dark_gray = "#454545", -- Gris claro para separadores y comentarios
		red = "#ff0000", -- Rojo brillante para errores y números (inalterado)
	}

	-- General UI Highlight Groups
	set(0, "Normal", { bg = colors.background, fg = colors.foreground })
	set(0, "NormalNC", { bg = colors.background, fg = colors.foreground })
	set(0, "Comment", { fg = colors.light_gray, italic = true })
	set(0, "ColorColumn", { bg = colors.light_gray })
	set(0, "CursorLine", { underline = true, bg = "none" })
	set(0, "CursorLineNr", { fg = colors.foreground, bg = "none" })
	set(0, "LineNr", { fg = colors.dark_gray })
	set(0, "SignColumn", { bg = colors.background })
	set(0, "StatusLine", { fg = colors.white, bg = colors.dark_gray })
	set(0, "StatusLineNC", { fg = colors.dark_gray, bg = colors.light_gray })
	set(0, "TabLine", { fg = colors.foreground, bg = colors.light_gray })
	set(0, "TabLineSel", { fg = colors.white, bg = colors.foreground })
	set(0, "TabLineFill", { bg = colors.light_gray })
	set(0, "Visual", { bg = colors.foreground, fg = colors.white })
	set(0, "Search", { fg = colors.background, bg = colors.dark_gray })
	set(0, "IncSearch", { fg = colors.background, bg = colors.foreground })
	set(0, "Error", { fg = colors.background, bg = colors.red, bold = true })
	set(0, "ErrorMsg", { fg = colors.red, bg = colors.dark_gray })
	set(0, "MsgArea", { fg = colors.foreground, bg = colors.background })
	set(0, "QuickFixLine", { fg = colors.red, bg = colors.background })
	set(0, "VertSplit", { fg = colors.light_gray, bg = colors.light_gray })
	set(0, "WinSeparator", { fg = colors.light_gray })

	-- Code syntax groups
	set(0, "Keyword", { fg = colors.foreground, bold = true })
	set(0, "String", { fg = colors.dark_gray })
	set(0, "Function", { fg = colors.foreground })
	set(0, "Identifier", { fg = colors.foreground })
	set(0, "Type", { fg = colors.foreground })
	set(0, "Number", { fg = colors.red })
	set(0, "Constant", { fg = colors.foreground })
	set(0, "Statement", { fg = colors.foreground })
	set(0, "PreProc", { fg = colors.foreground })
	set(0, "Delimiter", { fg = colors.foreground })
	set(0, "Special", { fg = colors.red })

	-- LSP Diagnostics Highlight Groups
	set(0, "DiagnosticSignError", { fg = colors.red, bg = colors.background })
	set(0, "DiagnosticSignWarn", { fg = colors.dark_gray, bg = colors.background })
	set(0, "DiagnosticSignInfo", { fg = colors.foreground, bg = colors.background })
	set(0, "DiagnosticSignHint", { fg = colors.dark_gray, bg = colors.background })

	-- Define signs for each diagnostic
	set_sign("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError", numhl = "" })
	set_sign("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn", numhl = "" })
	set_sign("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo", numhl = "" })
	set_sign("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint", numhl = "" })

	-- Floating windows and popup menu
	set(0, "NormalFloat", { bg = colors.background, fg = colors.foreground })
	set(0, "FloatBorder", { bg = colors.background, fg = colors.dark_gray })
	set(0, "FloatTitle", { bg = colors.background, fg = colors.foreground })
end

return M
