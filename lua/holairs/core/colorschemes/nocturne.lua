local palette = {
  clear = "#9c9eb4",
  smoke = "#353535",
  graphite = "#686c7d",
  darkness = "#000000",
  fog = "#96a8ad",
  blood = "#b07777",
  maroon = "#bc735c",
  sky = "#8796b0",
  moss = "#9cac9b",
  lagoon = "#79a0aa",
}

-- highlight groups
local highlights = {
  Normal = { fg = palette.clear, bg = "none" },
  Comment = { fg = palette.smoke },
  Constant = { fg = palette.sky },
  String = { fg = palette.moss },
  ColorColumn = { fg = palette.clear, bg = palette.smoke },
  Character = { fg = palette.maroon },
  Number = { fg = palette.sky },
  Boolean = { fg = palette.sky },
  Identifier = { fg = palette.clear },
  Function = { fg = palette.graphite },
  Statement = { fg = palette.fog },
  Conditional = { fg = palette.fog },
  Repeat = { fg = palette.fog },
  Label = { fg = palette.fog },
  Operator = { fg = palette.sky },
  Keyword = { fg = palette.fog },
  Exception = { fg = palette.blood },
  PreProc = { fg = palette.fog },
  Include = { fg = palette.blood },
  Define = { fg = palette.fog },
  Macro = { fg = palette.fog },
  PreCondit = { fg = palette.fog },
  Type = { fg = palette.blood },
  StorageClass = { fg = palette.fog },
  Structure = { fg = palette.blood },
  Typedef = { fg = palette.blood },
  Special = { fg = palette.blood },
  SpecialChar = { fg = palette.maroon },
  Visual = { fg = palette.darkness, bg = palette.graphite },
  Tag = { fg = palette.graphite },
  Delimiter = { fg = palette.blood },
  Directory = { fg = palette.moss },
  QuickFixLine = { fg = palette.blood },
  Question = { fg = palette.moss },
  TabLine = { bg = palette.smoke, fg = palette.clear },
  TabLineSel = { bg = palette.graphite, fg = palette.darkness },
  TabLineFill = { bg = palette.smoke, fg = palette.clear },
  WarningMsg = { bg = "none", fg = palette.lagoon },
  DiagnosticWarn = { bg = "none", fg = palette.lagoon },
  DiagnosticFloatingWarn = { bg = "none", fg = palette.lagoon },
  DiagnosticSignWarn = { bg = "none", fg = palette.lagoon },
  DiagnostifgirtualTextWarn = { bg = "none", fg = palette.lagoon },
  WarningError = { bg = "none", fg = palette.blood },
  DiagnosticError = { bg = "none", fg = palette.blood },
  DiagnosticFloatingError = { bg = "none", fg = palette.blood },
  DiagnosticSignError = { bg = "none", fg = palette.blood },
  DiagnostifgirtualTextError = { bg = "none", fg = palette.blood },
  WarningHint = { bg = "none", fg = palette.sky },
  DiagnosticHint = { bg = "none", fg = palette.sky },
  DiagnosticFloatingHint = { bg = "none", fg = palette.sky },
  DiagnosticSignHint = { bg = "none", fg = palette.sky },
  DiagnostifgirtualTextHint = { bg = "none", fg = palette.sky },
  SpecialComment = { fg = palette.graphite },
  Debug = { fg = palette.blood },
  Error = { fg = palette.blood },
  Todo = { fg = palette.darkness, bg = palette.sky, gui = "bold", cterm = "bold" }, -- Todo:
  StatusLine = { fg = palette.clear, bg = "none" },
  StatusLineNC = { fg = palette.clear, bg = "none" },
  MsgArea = { fg = palette.clear, bg = "none" },
  MsgSeparator = { fg = palette.clear, bg = "none" },
  ModeMsg = { fg = palette.sky, bg = "none" },
  MoreMsg = { fg = palette.moss },
  Cursor = { fg = palette.darkness, bg = palette.blood },
  IncSearch = { fg = palette.darkness, bg = palette.fog },
  Search = { fg = palette.darkness, bg = palette.fog },
  CurSearch = { fg = palette.darkness, bg = palette.fog },
  Underlined = { style = "none" },
  CursorInsert = { fg = palette.darkness, bg = palette.blood },
  CursorLineNr = { fg = palette.blood, bg = "none", style = "bold" },
  LineNr = { fg = palette.smoke, bg = "none" },
  NormalFloat = { bg = "none" },
  FloatBorder = { bg = "none" },

  -- Gitsigns symbols
  GitSignsAdd = { fg = palette.sky, bg = "none" },
  GitSignsChange = { fg = palette.maroon, bg = "none" },
  GitSignsDelete = { fg = palette.blood, bg = "none" },

  -- Highlights for Oil
  OilDir = { fg = palette.sky, bg = "none", style = "bold" },
  OilFile = { fg = palette.clear, bg = "none" },
  OilSymlink = { fg = palette.lagoon, bg = "none", style = "italic" },
  OilSelected = { fg = palette.darkness, bg = palette.blood, style = "bold" },
  OilBorder = { fg = palette.graphite, bg = "none" },

  -- Highlights for fzf-lua
  FzfLuaNormal = { fg = palette.clear, bg = "none" },
  FzfLuaBorder = { fg = palette.graphite, bg = "none" },
  FzfLuaCursor = { fg = palette.darkness, bg = palette.blood },
  FzfLuaPreview = { fg = palette.sky, bg = "none" },
  FzfLuaPrompt = { fg = palette.moss, bg = "none" },
  FzfLuaMatch = { fg = palette.maroon, bg = "none", style = "bold" },
  FzfLuaSelection = { fg = palette.darkness, bg = palette.lagoon, style = "bold" },
  FzfLuaTabTitle = { fg = palette.moss, bg = "none" },
  FzfLuaSelectionFzfLuaBufFlagAlt = { fg = palette.moss, bg = "none" },
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
