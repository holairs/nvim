local palette = {
  rosewater = "#e2d8c2", -- Un tono sepia suave, como el papel antiguo
  flamingo  = "#cc9966", -- Un marrón anaranjado retro
  pink      = "#d27d9e", -- Rosa oscuro, muy saturado
  mauve     = "#946dbb", -- Un púrpura apagado típico de terminales retro
  red       = "#cc6666", -- Rojo oscuro y mate
  maroon    = "#993333", -- Marrón rojizo
  peach     = "#d39b66", -- Naranja pastel
  yellow    = "#d7af5f", -- Amarillo mostaza, típico de esquemas retro
  green     = "#b0bc72", -- Verde oliva apagado
  teal      = "#668c8d", -- Verde azulado clásico
  sky       = "#6c99bb", -- Azul cielo con un tono frío
  sapphire  = "#45707a", -- Azul apagado
  blue      = "#7d8fbf", -- Azul pastel desaturado
  lavender  = "#8c7cba", -- Lavanda suave
  text      = "#d0c9c5", -- Blanco grisáceo para texto
  subtext1  = "#b2aba5", -- Gris medio para texto secundario
  subtext0  = "#918a84", -- Gris oscuro para texto tenue
  overlay2  = "#766e68", -- Gris pardo para overlays
  overlay1  = "#5c544f", -- Gris oscuro suave
  overlay0  = "#453f3a", -- Gris oscuro
  surface2  = "#37302a", -- Marrón grisáceo para superficies
  surface1  = "#2e2923", -- Marrón oscuro para elementos secundarios
  surface0  = "#221e19", -- Marrón muy oscuro para el fondo
  base      = "#1a1613", -- Casi negro, un fondo profundo y retro
  mantle    = "#13110e", -- Más oscuro que el fondo base
  crust     = "#0c0b08", -- Negro puro para contrastes altos
}

-- highlight groups
local highlights = {
  Normal         = { fg = palette.text, bg = "none" },
  Comment        = { fg = palette.overlay2 },
  Constant       = { fg = palette.peach },
  String         = { fg = palette.green },
  Character      = { fg = palette.pink },
  Number         = { fg = palette.peach },
  Boolean        = { fg = palette.peach },
  Float          = { fg = palette.peach },
  Identifier     = { fg = palette.text },
  Function       = { fg = palette.blue },
  Statement      = { fg = palette.mauve },
  Conditional    = { fg = palette.mauve },
  Repeat         = { fg = palette.mauve },
  Label          = { fg = palette.mauve },
  Operator       = { fg = palette.sky },
  Keyword        = { fg = palette.mauve },
  Exception      = { fg = palette.red },
  PreProc        = { fg = palette.mauve },
  Include        = { fg = palette.red },
  Define         = { fg = palette.mauve },
  Macro          = { fg = palette.mauve },
  PreCondit      = { fg = palette.mauve },
  Type           = { fg = palette.yellow },
  StorageClass   = { fg = palette.mauve },
  Structure      = { fg = palette.yellow },
  Typedef        = { fg = palette.yellow },
  Special        = { fg = palette.red },
  SpecialChar    = { fg = palette.pink },
  Tag            = { fg = palette.blue },
  Delimiter      = { fg = palette.overlay2 },
  SpecialComment = { fg = palette.overlay2 },
  Debug          = { fg = palette.red },
  Underlined     = { style = "underline" },
  Error          = { fg = palette.red },
  Todo           = { fg = palette.teal, style = "bold" },
  StatusLine     = { fg = palette.rosewater, bg = palette.crust },
  StatusLineNC   = { fg = palette.rosewater, bg = palette.crust },
  -- Cmdline        = { fg = palette.text, bg = palette.rosewater },
  -- CmdlinePrompt  = { fg = palette.text, bg = palette.rosewater },
  MsgArea        = { fg = palette.crust, bg = palette.rosewater },
  MsgSeparator   = { fg = palette.crust, bg = palette.rosewater },
  Cursor         = { fg = palette.crust, bg = palette.red },
  CursorInsert   = { fg = palette.crust, bg = palette.red }
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
