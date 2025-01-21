local palette = {
  sepia    = "#e2d8c2",
  amber    = "#cc9966",
  rosewood = "#d27d9e",
  grappe   = "#946dbb",
  cherry   = "#cc6666",
  wine     = "#862d2d",
  peach    = "#d39b66",
  mustard  = "#d7af5f",
  olive    = "#b0bc72",
  lagoon   = "#668c8d",
  sky      = "#6c99bb",
  sapphire = "#45707a",
  blue     = "#7d8fbf",
  lavender = "#8c7cba",
  silver   = "#766e68",
  charcoal = "#221e19",
  base     = "#221e19",
  crust    = "#0c0b08",
}

-- highlight groups
local highlights = {
  Normal         = { fg = palette.sepia, bg = "none" },
  Comment        = { fg = palette.silver },
  Constant       = { fg = palette.peach },
  String         = { fg = palette.olive },
  Character      = { fg = palette.rosewood },
  Number         = { fg = palette.rosewood },
  Boolean        = { fg = palette.peach },
  Float          = { fg = palette.peach },
  Identifier     = { fg = palette.sepia },
  Function       = { fg = palette.blue },
  Statement      = { fg = palette.grappe },
  Conditional    = { fg = palette.grappe },
  Repeat         = { fg = palette.grappe },
  Label          = { fg = palette.grappe },
  Operator       = { fg = palette.sky },
  Keyword        = { fg = palette.grappe },
  Exception      = { fg = palette.cherry },
  PreProc        = { fg = palette.grappe },
  Include        = { fg = palette.cherry },
  Define         = { fg = palette.grappe },
  Macro          = { fg = palette.grappe },
  PreCondit      = { fg = palette.grappe },
  Type           = { fg = palette.mustard },
  StorageClass   = { fg = palette.grappe },
  Structure      = { fg = palette.mustard },
  Typedef        = { fg = palette.mustard },
  Special        = { fg = palette.cherry },
  SpecialChar    = { fg = palette.rosewood },
  Tag            = { fg = palette.blue },
  Delimiter      = { fg = palette.cherry },
  SpecialComment = { fg = palette.silver },
  Debug          = { fg = palette.cherry },
  Error          = { fg = palette.cherry },
  Todo           = { fg = palette.lagoon, style = "bold" }, -- Todo:
  StatusLine     = { fg = palette.sepia, bg = palette.crust },
  StatusLineNC   = { fg = palette.sepia, bg = palette.crust },
  MsgArea        = { fg = palette.sepia, bg = "none" },
  MsgSeparator   = { fg = palette.sepia, bg = "none" },
  Underlined     = { style = "underline" },
  Cursor         = { fg = palette.crust, bg = palette.cherry },
  CursorInsert   = { fg = palette.crust, bg = palette.cherry },
  CursorLineNr   = { fg = palette.mustard, bg = "none" , style = "bold"},
  LineNr         = { bg = "none" },

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
end
