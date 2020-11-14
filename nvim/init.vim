set title  " Muestra el nombre del archivo en la ventana de la terminal
set relativenumber  " Muestra los números de las líneas
set mouse=a  " Permite la integración del mouse (seleccionar texto, mover el cursor)

set nowrap  " No dividir la línea si es muy larga

set cursorline  " Resalta la línea actual
set colorcolumn=120  " Muestra la columna límite a 120 caracteres

" Indentación a 4 espacios
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab  " Insertar espacios en lugar de <Tab>s

set hidden  " Permitir cambiar de buffers sin tener que guardarlos

set ignorecase  " Ignorar mayúsculas al hacer una búsqueda
set smartcase  " No ignorar mayúsculas si la palabra a buscar contiene mayúsculas

set spelllang=en,es  " Corregir palabras usando diccionarios en inglés y español

set termguicolors  " Activa true colors en la terminal


" -------------------
" TECLAS RAPIDAS
" --------------------

let g:mapleader = ' '  " Definir espacio como la tecla líder
nnoremap <leader>s :w<CR>  " Guardar con <líder> + s

nnoremap <leader>e :e $MYVIMRC<CR>  " Abrir el archivo init.vim con <líder> + e

" Usar <líder> + y para copiar al portapapeles
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" Usar <líder> + d para cortar al portapapeles
vnoremap <leader>d "+d
nnoremap <leader>d "+d

" Usar <líder> + p para pegar desde el portapapeles
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P

" Moverse al buffer siguiente con <líder> + l
nnoremap <leader>l :bnext<CR>

" Moverse al buffer anterior con <líder> + j
nnoremap <leader>j :bprevious<CR>

" Cerrar el buffer actual con <líder> + q
nnoremap <leader>q :bdelete<CR>

" -------------------
" END TECLAS RAPIDAS
" --------------------

" -------------------
" PLUGINS
" --------------------
call plug#begin('~/.config/nvim/plugged')

"Git wrapper
Plug 'tpope/vim-fugitive'

"Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

"Status and tabline Vim
Plug 'vim-airline/vim-airline'

"Airline themes
Plug 'vim-airline/vim-airline-themes'

" Check syntax with ale
Plug 'w0rp/ale'

" For pretting the code
Plug 'prettier/vim-prettier'

" Color scheme
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

" -------------------
" END PLUGINS
" --------------------

"               -----------  AIRLINE CONFIGURATION ---------
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" enable modified detection >
  let g:airline_detect_modified=1

" enable paste detection >
  let g:airline_detect_paste=1

" enable crypt detection >
  let g:airline_detect_crypt=1

" enable spell detection >
  let g:airline_detect_spell=1

" display spelling language when spell detection is enabled
"  (if enough space is available) >
  let g:airline_detect_spelllang=1

" enable iminsert detection >
  let g:airline_detect_iminsert=0

" determine whether inactive windows should have the left section collapsed
"  to only the filename of that buffer.  >
  let g:airline_inactive_collapse=1

" themes are automatically selected based on the matching colorscheme. this
"  can be overridden by defining a value. >
  let g:airline_theme='simple'

" define the set of names to be displayed instead of a specific filetypes
" (for section a and b): >
  let g:airline_filetype_overrides = {
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ }
"               --------------------------------------------

"               -------------  POWERLINE SYMBOLS -----------
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
"               --------------------------------------------

"               -------------  ALE CONFIGURATION -----------
"Ale only appears in save
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
"               --------------------------------------------

"               --------------  SET COLORSCHEME ------------
set background=dark  " Fondo del tema: light o dark
colorscheme gruvbox  " Nombre del tema
"               --------------------------------------------
