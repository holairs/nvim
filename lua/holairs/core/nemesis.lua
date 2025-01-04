-- lua/holairs/core/nemesis.lua

-- Name: Nemesis
-- Author: Holairs
-- Colorscheme based on the Nemesis art cover from the Isaac Asimov's "Nemesis" book
-- It's a dark colorscheme with a dark background and bright colors for the syntax
-- The colors represent the colors of the stars in the cover of the book

local M = {}
local set = vim.api.nvim_set_hl
local set_sign = vim.fn.sign_define

function M.setup()
	vim.o.background = "dark"
	vim.cmd([[hi clear]])
	if vim.fn.exists("syntax_on") then
		vim.cmd([[syntax reset]])
	end

	vim.g.colors_name = "nemesis"

	-- Define colors
	local colors = {
		background = "#0D0D12",
		foreground = "#D3D7DE",
		light_gray = "#484F59",
		dark_gray = "#20232a",
		mid_gray = "#202022",
		blue = "#5353BA",
		red = "#B34040",
		yellow = "#F1C40F",
		orange = "#E67E22",
		orange_2 = "#b56809",
		green = "#2ECC71",
		purple = "#9B59B6",
		light_blue = "#5353BA",
		hard_red = "#ff0000",
	}

	-- General UI
	set(0, "Normal", { bg = "none" })
	set(0, "NormalNC", { bg = "none" })
	set(0, "Comment", { fg = colors.light_gray, italic = true })
	set(0, "ColorColumn", { bg = colors.dark_gray })
	set(0, "LineNr", { fg = colors.light_gray, bg = "none" })
	set(0, "CursorLine", { underline = true, ctermbg = "NONE" })
	set(0, "CursorLineNr", { fg = colors.yellow, bg = "none" })
	set(0, "SignColumn", { fg = "none", bg = "none" })
	set(0, "StatusLine", { fg = colors.foreground, bg = colors.dark_gray })
	set(0, "StatusLineNC", { fg = colors.foreground, bg = colors.mid_gray })
	set(0, "TabLine", { fg = colors.foreground, bg = colors.dark_gray })
	set(0, "TabLineSel", { fg = colors.foreground, bg = colors.blue })
	set(0, "TabLineFill", { bg = colors.dark_gray })
	set(0, "VertSplit", { fg = colors.dark_gray, bg = colors.dark_gray })
	set(0, "WinSeparator", { fg = "none", bg = "none" })
	set(0, "Visual", { bg = colors.light_gray })
	set(0, "Error", { fg = colors.hard_red, bold = true })
	set(0, "CmdLine", { fg = colors.foreground, bg = "none" })
	set(0, "CmdLineBorder", { fg = colors.dark_gray, bg = "none" })
	set(0, "MsgArea", { fg = colors.foreground, bg = "none" })
	set(0, "MsgSeparator", { fg = colors.dark_gray, bg = "none" })

	-- Floating windows
	set(0, "NormalFloat", { bg = "none", ctermbg = "none" })
	set(0, "FloatBorder", { bg = "none", ctermbg = "none" })

	-- LSP Diagnostics
	set(0, "DiagnosticSignError", { fg = colors.red, bg = colors.dark_gray })
	set(0, "DiagnosticSignWarn", { fg = colors.yellow, bg = colors.dark_gray })
	set(0, "DiagnosticSignInfo", { fg = colors.light_blue, bg = colors.dark_gray })
	set(0, "DiagnosticSignHint", { fg = colors.purple, bg = colors.dark_gray })

	-- Define los signos para cada diagnóstico
	set_sign("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError", numhl = "" })
	set_sign("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn", numhl = "" })
	set_sign("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo", numhl = "" })
	set_sign("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint", numhl = "" })

	-- Code syntax
	set(0, "Keyword", { fg = colors.red, bold = true })
	set(0, "String", { fg = colors.light_blue })
	set(0, "Function", { fg = colors.foreground, bold = true })
	set(0, "Identifier", { fg = colors.red })
	set(0, "Type", { fg = colors.blue })
	set(0, "Number", { fg = colors.yellow })
	set(0, "Constant", { fg = colors.orange })
	set(0, "Statement", { fg = colors.orange, bold = true })
	set(0, "PreProc", { fg = colors.purple })
	set(0, "Delimiter", { fg = colors.orange_2 })
	set(0, "Special", { fg = colors.light_blue })

	-- Plugins
	-- Gitsigns
	set(0, "GitSignsAdd", { fg = colors.green, bg = "none" })
	set(0, "GitSignsChange", { fg = colors.yellow, bg = "none" })
	set(0, "GitSignsDelete", { fg = colors.red, bg = "none" })

	-- Folke Noice (In progress)

	-- Folke Snacks
	set(0, "SnacksIndentScope", { fg = colors.orange, bg = "none" })

	-- nvim-tree
	set(0, "NvimtreeFolderName", { fg = colors.white })
	set(0, "NvimtreeOpenFolderName", { fg = colors.white })
	set(0, "NvimtreeEmptyFolderName", { fg = colors.white })

	-- BlinkCmp Highlight Groups
	set(0, "BlinkCmpMenu", { bg = colors.dark_gray, fg = colors.foreground })
	set(0, "BlinkCmpMenuBorder", { bg = "none", fg = colors.dark_gray })
	set(0, "BlinkCmpMenuSelection", { bg = colors.blue, fg = colors.foreground, bold = true })
	set(0, "BlinkCmpScrollBarThumb", { bg = colors.blue, fg = colors.light_gray })
	set(0, "BlinkCmpLabelMatch", { fg = colors.orange, bold = true })
	set(0, "BlinkCmpKind", { fg = colors.purple, bg = "none" })
	set(0, "BlinkCmpSource", { fg = colors.yellow, bg = "none", italic = true })
	set(0, "BlinkCmpGhostText", { fg = colors.orange, italic = true })
	set(0, "BlinkCmpSignatureHelpBorder", { bg = "none", fg = colors.dark_gray })
	set(0, "BlinkCmpSignatureHelpActiveParameter", { fg = colors.orange, bold = true, italic = true })
end
return M
