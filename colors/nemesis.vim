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
hi Keyword guifg=#4040b3 gui=bold
hi String guifg=#b34040
hi Function guifg=#d3d7de gui=bold
hi Identifier guifg=#4040b3
hi Type guifg=#b34040
hi Number guifg=#4040b3
hi Constant guifg=#b34040
hi Statement guifg=#4040b3 gui=bold
hi PreProc guifg=#b34040

" Fondo para la columna de color y otros
hi VertSplit guibg=#0d0d12 guifg=#3b3f45

" Otros elementos
hi Error guifg=#ff5555 guibg=#0d0d12 gui=bold     
hi Visual guibg=#3b3f45                           
