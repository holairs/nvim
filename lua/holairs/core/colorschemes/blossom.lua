local palette = {
	sepia = "#e2d8c2",
	amber = "#cc9966",
	rosewood = "#d27d9e",
	grappe = "#946dbb",
	cherry = "#cc6666",
	wine = "#862d2d",
	peach = "#d39b66",
	mustard = "#d7af5f",
	olive = "#b0bc72",
	lagoon = "#668c8d",
	sky = "#6c99bb",
	sapphire = "#45707a",
	blue = "#7d8fbf",
	lavender = "#8c7cba",
	silver = "#766e68",
	charcoal = "#140e08",
	base = "#161410",
	crust = "#0c0b08",
}

-- highlight groups
local highlights = {
	Normal = { fg = palette.sepia, bg = "none" },
	Comment = { fg = palette.silver },
	Constant = { fg = palette.peach },
	String = { fg = palette.olive },
	Character = { fg = palette.rosewood },
	Number = { fg = palette.rosewood },
	Boolean = { fg = palette.peach },
	Float = { fg = palette.peach },
	Identifier = { fg = palette.sepia },
	Function = { fg = palette.blue },
	Statement = { fg = palette.grappe },
	Conditional = { fg = palette.grappe },
	Repeat = { fg = palette.grappe },
	Label = { fg = palette.grappe },
	Operator = { fg = palette.sky },
	Keyword = { fg = palette.grappe },
	Exception = { fg = palette.cherry },
	PreProc = { fg = palette.grappe },
	Include = { fg = palette.cherry },
	Define = { fg = palette.grappe },
	Macro = { fg = palette.grappe },
	PreCondit = { fg = palette.grappe },
	Type = { fg = palette.mustard },
	StorageClass = { fg = palette.grappe },
	Structure = { fg = palette.mustard },
	Typedef = { fg = palette.mustard },
	Special = { fg = palette.cherry },
	SpecialChar = { fg = palette.rosewood },
	Tag = { fg = palette.blue },
	Delimiter = { fg = palette.cherry },
	SpecialComment = { fg = palette.silver },
	Debug = { fg = palette.cherry },
	Error = { fg = palette.cherry },
	Todo = { fg = palette.lagoon, style = "bold" }, -- Todo:
	StatusLine = { fg = palette.sepia, bg = palette.crust },
	StatusLineNC = { fg = palette.sepia, bg = palette.crust },
	MsgArea = { fg = palette.sepia, bg = "none" },
	MsgSeparator = { fg = palette.sepia, bg = "none" },
	Underlined = { style = "underline" },
	Cursor = { fg = palette.crust, bg = palette.cherry },
	CursorInsert = { fg = palette.crust, bg = palette.cherry },
	CursorLineNr = { fg = palette.mustard, bg = "none", style = "bold" },
	LineNr = { bg = "none" },
	NormalFloat = { bg = "none" },
	FloatBorder = { bg = "none" },


	-- Gitsigns symbols
	GitSignsAdd = { fg = palette.lagoon, bg = "none" },
	GitSignsChange = { fg = palette.charcoal, bg = "none" },
	GitSignsDelete = { fg = palette.blood, bg = "none" },

	-- Highlights for Oil
	OilDir = { fg = palette.sapphire, bg = "none", style = "bold" },
	OilFile = { fg = palette.blue, bg = "none" },
	OilSymlink = { fg = palette.blue, bg = "none", style = "italic" },
	OilSelected = { fg = palette.blue, bg = palette.blood, style = "bold" },
	OilBorder = { fg = palette.blue, bg = "none" },

	-- Highlights for fzf-lua
	FzfLuaNormal = { fg = palette.amber, bg = "none" },
	FzfLuaBorder = { fg = palette.grappe, bg = "none" },
	FzfLuaCursor = { fg = palette.lagoon, bg = palette.blood },
	FzfLuaPreview = { fg = palette.blue, bg = "none" },
	FzfLuaPrompt = { fg = palette.grappe, bg = "none" },
	FzfLuaMatch = { fg = palette.amber, bg = "none", style = "bold" },
	FzfLuaSelection = { fg = palette.wine, bg = palette.lagoon, style = "bold" },
	FzfLuaTabTitle = { fg = palette.peach, bg = "none" },
	FzfLuaSelectionFzfLuaBufFlagAlt = { fg = palette.charcoal, bg = "none" },

}

-- apply highlights
for group, opts in pairs(highlights) do
	local cmd = "highlight " .. group
	if opts.fg then
		cmd = cmd .. " guifg=" .. opts.fg
	end
	if opts.bg then
		cmd = cmd .. " guibg=" .. opts.bg
	end
	if opts.style then
		cmd = cmd .. " gui=" .. opts.style
	end
	vim.cmd(cmd)

	-- Force CursorLine underline style
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = true })
end
