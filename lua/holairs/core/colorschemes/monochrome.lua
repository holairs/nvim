-- lua/holairs/core/colroschemes/monochrome.lua

-------------------------------------------------------------------------------
--------------------------- Monochrome Colorscheme ----------------------------
-------------------------------------------------------------------------------
--  Name: Monochrome                                                         --
--  Author: Holairs                                                          --
--  A minimalistic colorscheme inspired by shades of gray and monochromatic  --
--  tones, designed for a dark background. The palette focuses on subtle     --
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
	vim.o.background = "dark"
	vim.cmd([[hi clear]])
	if vim.fn.exists("syntax_on") then
		vim.cmd([[syntax reset]])
	end

	vim.g.colors_name = "monochrome"

	-- Define colors
	local colors = {
		background = "none",
		foreground = "#bcbcbc", -- Texto principal en un gris claro
		light_gray = "#d0d0d0", -- Gris claro para constantes
		dark_gray = "#585858", -- Gris oscuro para separadores y comentarios
		mid_gray = "#303030", -- Gris intermedio para resaltados menores
		blue = "#8a8a8a", -- Azul desaturado para cadenas
		red = "#ff0000", -- Rojo brillante para errores y números
		yellow = "#eeeeee", -- Gris cálido para palabras clave
		orange = "#d70000", -- Rojo oscuro para cambios
		dark_orange = "#870000", -- Rojo profundo para mensajes de error
		purple = "#af0000", -- Púrpura oscuro para texto resaltado
		light_blue = "#eeeeee", -- Gris muy claro para detalles menores
		hard_red = "#ff0000", -- Rojo intenso para valores críticos
	}

	-- General UI Highlight Groups
	set(0, "Normal", { bg = colors.background, fg = colors.foreground })
	set(0, "NormalNC", { bg = colors.background, fg = colors.foreground })
	set(0, "Comment", { fg = colors.dark_gray, italic = true })
	set(0, "ColorColumn", { bg = colors.mid_gray })
	set(0, "CursorLine", { underline = false, ctermbg = "NONE" })
	set(0, "CursorLineNr", { fg = colors.yellow, bg = "none" })
	set(0, "LineNr", { fg = colors.dark_gray })
	set(0, "SignColumn", { bg = colors.background })
	set(0, "StatusLine", { fg = colors.blue, bg = colors.background })
	set(0, "StatusLineNC", { fg = colors.mid_gray, bg = colors.background })
	set(0, "TabLine", { fg = colors.foreground, bg = colors.dark_gray })
	set(0, "TabLineSel", { fg = colors.yellow, bg = colors.blue })
	set(0, "TabLineFill", { bg = colors.dark_gray })
	set(0, "Visual", { bg = colors.dark_orange, fg = colors.foreground })
	set(0, "Search", { fg = colors.blue, bg = colors.mid_gray })
	set(0, "IncSearch", { fg = colors.yellow, bg = colors.blue })
	set(0, "Error", { fg = colors.light_blue, bg = colors.dark_orange, bold = true })
	set(0, "ErrorMsg", { fg = colors.yellow, bg = colors.purple })
	set(0, "MsgArea", { fg = colors.foreground, bg = "none" })
	set(0, "MsgSeparator", { fg = colors.dark_gray })
	set(0, "QuickFixLine", { fg = colors.orange, bg = colors.background })
	set(0, "VertSplit", { fg = colors.dark_gray, bg = colors.dark_gray })
	set(0, "WinSeparator", { fg = colors.dark_gray })

	-- Code syntax groups
	set(0, "Keyword", { fg = colors.yellow, bold = true })
	set(0, "String", { fg = colors.blue })
	set(0, "Function", { fg = colors.light_gray, bold = true })
	set(0, "Identifier", { fg = colors.foreground })
	set(0, "Type", { fg = colors.light_gray })
	set(0, "Number", { fg = colors.red })
	set(0, "Constant", { fg = colors.orange })
	set(0, "Statement", { fg = colors.purple })
	set(0, "PreProc", { fg = colors.yellow })
	set(0, "Delimiter", { fg = colors.dark_gray })
	set(0, "Special", { fg = colors.light_blue })

	-- LSP Diagnostics Highlight Groups
	set(0, "DiagnosticSignError", { fg = colors.red, bg = colors.dark_gray })
	set(0, "DiagnosticSignWarn", { fg = colors.yellow, bg = colors.dark_gray })
	set(0, "DiagnosticSignInfo", { fg = colors.light_blue, bg = colors.dark_gray })
	set(0, "DiagnosticSignHint", { fg = colors.purple, bg = colors.dark_gray })

	-- Define signs for each diagnostic
	set_sign("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError", numhl = "" })
	set_sign("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn", numhl = "" })
	set_sign("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo", numhl = "" })
	set_sign("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint", numhl = "" })

	-- Floating windows and popup menu
	set(0, "NormalFloat", { bg = "none", ctermbg = "none" })
	set(0, "FloatBorder", { bg = "none", fg = colors.orange, ctermbg = "none" })
	set(0, "FloatTitle", { bg = "none", fg = colors.yellow, ctermbg = "none" })

	-- Gitsigns Highlight Groups
	set(0, "GitSignsAdd", { fg = colors.blue, bg = "none" })
	set(0, "GitSignsChange", { fg = colors.dark_orange, bg = "none" })
	set(0, "GitSignsDelete", { fg = colors.red, bg = "none" })

	-- Folke Snacks Highlight Groups
	set(0, "SnacksIndentScope", { fg = colors.orange, bg = "none" })

	-- Nvim-Tree Highlight Groups
	set(0, "NvimTreeNormal", { bg = colors.background, fg = colors.foreground })
	set(0, "NvimTreeFolderName", { fg = colors.blue })
	set(0, "NvimTreeOpenedFolderName", { fg = colors.light_blue, bold = true })
	set(0, "NvimTreeEmptyFolderName", { fg = colors.light_gray, italic = true })
	set(0, "NvimTreeFolderIcon", { fg = colors.blue })
	set(0, "NvimTreeIndentMarker", { fg = colors.light_gray })
	set(0, "NvimTreeExecFile", { fg = colors.light_blue, bold = true })
	set(0, "NvimTreeSpecialFile", { fg = colors.orange, bold = true, italic = true })
	set(0, "NvimTreeImageFile", { fg = colors.purple })
	set(0, "NvimTreeGitDirty", { fg = colors.yellow })
	set(0, "NvimTreeGitStaged", { fg = colors.light_blue })
	set(0, "NvimTreeGitMerge", { fg = colors.orange })
	set(0, "NvimTreeGitRenamed", { fg = colors.purple })
	set(0, "NvimTreeGitNew", { fg = colors.light_blue })
	set(0, "NvimTreeGitDeleted", { fg = colors.red })
	set(0, "NvimTreeSymlink", { fg = colors.orange, bold = true })
	set(0, "NvimTreeRootFolder", { fg = colors.dark_orange, bold = true })

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

	-- Nvim-CMP Highlight Groups
	set(0, "CmpItemAbbr", { fg = colors.foreground })
	set(0, "CmpItemAbbrDeprecated", { fg = colors.light_gray, italic = true })
	set(0, "CmpItemAbbrMatch", { fg = colors.orange, bold = true })
	set(0, "CmpItemAbbrMatchFuzzy", { fg = colors.orange, bold = true, italic = true })
	set(0, "CmpItemAbbrMatchFuzzySelected", { fg = colors.orange, bold = true, italic = true })
	set(0, "CmpItemAbbrMatchSelected", { fg = colors.orange, bold = true })
	set(0, "CmpDocNormal", { bg = colors.mid_gray, fg = colors.foreground })
	set(0, "CmpDocBorder", { bg = "none", fg = "none" })

	-- Oil Highlight Groups
	set(0, "OilChange", { fg = colors.yellow, bg = "none", bold = true })
	set(0, "OilCopy", { fg = colors.blue, bg = "none" })
	set(0, "OilCreate", { fg = colors.light_blue, bg = "none", bold = true })
	set(0, "OilDelete", { fg = colors.red, bg = "none", bold = true })
	set(0, "OilDir", { fg = colors.blue, bg = "none", bold = true })
	set(0, "OilDirHidden", { fg = colors.light_gray, bg = "none", italic = true })
	set(0, "OilDirIcon", { fg = colors.blue, bg = "none" })
	set(0, "OilFileHidden", { fg = colors.light_gray, bg = "none", italic = true })
	set(0, "OilHidden", { fg = colors.light_gray, bg = "none", italic = true })
	set(0, "OilLinkHidden", { fg = colors.purple, bg = "none", italic = true })
	set(0, "OilLinkTarget", { fg = colors.orange, bg = "none", bold = true })
	set(0, "OilLinkTargetHidden", { fg = colors.dark_orange, bg = "none", italic = true })
	set(0, "OilMove", { fg = colors.yellow, bg = "none", bold = true })
	set(0, "OilOrphanLinkHidden", { fg = colors.red, bg = "none", italic = true })
	set(0, "OilOrphanLinkTarget", { fg = colors.purple, bg = "none", bold = true })
	set(0, "OilOrphanLinkTargetHidden", { fg = colors.light_gray, bg = "none", italic = true })
	set(0, "OilPurge", { fg = colors.hard_red, bg = "none", bold = true })
	set(0, "OilRestore", { fg = colors.yellow, bg = "none", bold = true })
	set(0, "OilSocket", { fg = colors.blue, bg = "none", bold = true })
	set(0, "OilSocketHidden", { fg = colors.light_gray, bg = "none", italic = true })
	set(0, "OilTrash", { fg = colors.red, bg = "none", bold = true })
	set(0, "OilTrashSourcePath", { fg = colors.orange, bg = "none", italic = true })
	set(0, "OilFile", { fg = colors.foreground, bg = "none" })

	-- Indent Blankline Highlight Groups
	set(0, "IndentBlanklineChar", { fg = colors.light_blue, nocombine = true })
	set(0, "IndentBlanklineContextChar", { fg = colors.orange, nocombine = true })

	-- Alpha Dashboard Highlight Groups
	set(0, "AlphaBanner", { fg = colors.orange, bg = "none" })

	-- Neotree Highlight Groups
	set(0, "NeoTreeNormal", { fg = colors.foreground, bg = colors.background })
	set(0, "NeoTreeNormalNC", { fg = colors.foreground, bg = colors.background })
	set(0, "NeoTreeCursorLine", { underline = true })
	set(0, "NeoTreeEndOfBuffer", { fg = colors.background })
	set(0, "NeoTreeDirectoryName", { fg = colors.blue, bold = true })
	set(0, "NeoTreeDirectoryIcon", { fg = colors.blue })
	set(0, "NeoTreeFileName", { fg = colors.foreground })
	set(0, "NeoTreeFileNameOpened", { fg = colors.orange, bold = true })
	set(0, "NeoTreeDotfile", { fg = colors.light_gray, italic = true })
	set(0, "NeoTreeGitAdded", { fg = colors.blue })
	set(0, "NeoTreeGitModified", { fg = colors.yellow })
	set(0, "NeoTreeGitDeleted", { fg = colors.red })
	set(0, "NeoTreeGitRenamed", { fg = colors.purple })
	set(0, "NeoTreeGitUntracked", { fg = colors.orange })
	set(0, "NeoTreeGitConflict", { fg = colors.hard_red, bold = true })
	set(0, "NeoTreeGitIgnored", { fg = colors.light_gray })
	set(0, "NeoTreeIndentMarker", { fg = colors.dark_orange })
	set(0, "NeoTreeTabActive", { fg = colors.foreground, bg = colors.blue, bold = true })
	set(0, "NeoTreeTabInactive", { fg = colors.foreground, bg = colors.dark_gray })
	set(0, "NeoTreeTabSeparatorActive", { fg = colors.blue, bg = colors.blue })
	set(0, "NeoTreeTabSeparatorInactive", { fg = colors.dark_gray, bg = colors.dark_gray })
	set(0, "NeoTreeFloatBorder", { fg = colors.orange, bg = colors.background })
	set(0, "NeoTreeWinSeparator", { fg = colors.dark_gray, bg = colors.background })
	set(0, "NeoTreeVertSplit", { fg = colors.dark_gray, bg = colors.background })
	set(0, "NeoTreeMessage", { fg = colors.light_gray })
	set(0, "NeoTreeTitleBar", { fg = colors.foreground, bg = colors.dark_gray, bold = true })
	set(0, "NeoTreeRootName", { fg = colors.dark_orange, bold = true })

	-- Netrw Highlight Groups
	set(0, "Directory", { fg = colors.blue, bg = "none", bold = true })
	set(0, "NetrwDir", { fg = colors.blue, bg = "none", bold = true })
	set(0, "NetrwExec", { fg = colors.light_blue, bg = "none" })
	set(0, "NetrwPlain", { fg = colors.foreground, bg = "none" })
	set(0, "NetrwSymLink", { fg = colors.purple, bg = "none", italic = true })
	set(0, "NetrwLink", { fg = colors.orange, bg = "none" })
	set(0, "NetrwClassify", { fg = colors.light_gray, bg = "none" })
	set(0, "NetrwMarkFile", { fg = colors.yellow, bg = "none", bold = true })
	set(0, "NetrwLinkTarget", { fg = colors.orange, bg = "none", bold = true })
	set(0, "NetrwLinkTargetHidden", { fg = colors.light_gray, bg = "none", italic = true })
end
return M
