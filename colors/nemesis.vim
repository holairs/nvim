" Set dark background and clean previous configurations
set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "holairs_nemesis"

" Fondo general y texto
hi Normal guifg=#d3d7de guibg=#0d0d12

" Comentarios
hi Comment guifg=#5f6f7f gui=italic

" Color de columna
hi ColorColumn guibg=#0d0d12

" Números de línea
hi LineNr guifg=#3b3f45
hi CursorLineNr guifg=#b3b3ff

" SignColumn (para elementos como diagnósticos)
hi SignColumn guibg=#0d0d12 guifg=#3b3f45

" Línea de estado
hi StatusLine guifg=#ffffff guibg=#303030
hi StatusLineNC guifg=#d3d7de guibg=#20232a

" Tabline (barra de pestañas)
hi TabLine guifg=#d3d7de guibg=#20232a
hi TabLineSel guifg=#ffffff guibg=#4040b3
hi TabLineFill guibg=#20232a

" Fondo de la línea actual
hi CursorLine guibg=#db4f36

" Sintaxis del código
hi Keyword guifg=#4040b3 gui=bold                      " Palabras clave (azul oscuro)
hi String guifg=#b34040                                " Cadenas de texto (rojo oscuro)
hi Function guifg=#d3d7de gui=bold                     " Funciones (gris claro)
hi Identifier guifg=#4040b3                            " Identificadores/variables (azul oscuro)
hi Type guifg=#b34040                                  " Tipos de datos (rojo oscuro)
hi Number guifg=#4040b3                                " Números (azul oscuro)
hi Constant guifg=#b34040                              " Constantes (rojo oscuro)
hi Statement guifg=#4040b3 gui=bold                    " Declaraciones (azul oscuro)
hi PreProc guifg=#b34040                               " Preprocesadores (rojo oscuro)

" Fondo para la columna de color y otros elementos
hi VertSplit guibg=#0d0d12 guifg=#3b3f45

" Otros elementos
hi Error guifg=#ff5555 guibg=#0d0d12 gui=bold          " Errores
hi Visual guibg=#3b3f45                                " Selección visual
