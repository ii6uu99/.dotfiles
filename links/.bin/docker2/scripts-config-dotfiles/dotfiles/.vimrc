call pathogen#infect()
" Subsurface coding style
filetype plugin indent on
filetype detect
set cindent tabstop=8 shiftwidth=8 cinoptions=l1,:0,(0,g0
" TODO: extern "C" gets indented
" TODO: content of class blocks gets indented
"
" And some sane defaults, optional, but quite nice
set nocompatible
syntax on
" colorscheme industry
" colorscheme solarized
" colorscheme darkblue
colorscheme elflord
set hls
set is
set nu
" The default blue is just impossible to see on a black terminal
highlight Comment ctermfg=Brown
" clearly point out when someone have trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/
"
" Añadido por Salva
autocmd FileType text setlocal textwidth=78
highlight Normal ctermbg=none
"
" Añadimos Vimplate, pero no funciona
let Vimplate = "/usr/bin/vimplate"

" Ajustes de NERD_tree
" Autoarranque si iniciamos vim sin archivo (del FAQ)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Mapeo de tecla para abrir NERD_tree
map <C-n> :NERDTreeToggle<CR>

let mapleader=","
"
" Ajustes de airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline#extensions#branch#enabled = 1	"activa integracion de fugitive
" let g:airline_theme='zenburn'
let g:airline_theme='powerlineish'
" let g:airline_theme='serene'
" let g:airline_theme='tomorrow'
" let g:airline_theme='xtermlight'
" let g:airline_right_sep='|'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
let g:airline#extensions#capslock#enabled = 1

" powerline
" set rtp+=/usr/lib/python2.7/dist-packages/powerline/bindings/vim
set laststatus=2
set showtabline=2
set t_Co=256

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
