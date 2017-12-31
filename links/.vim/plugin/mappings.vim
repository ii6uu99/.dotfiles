" change the mapleader from \ to ,
let mapleader=","

noremap <leader>y "*y
noremap <leader>yy "*Y
:nmap <leader>m :Rmodel<Space>
:nmap <leader>c :Rcontroller<Space>
:nmap <leader>v :Rview<Space>
:nmap <leader>j :Rjavascript<Space>
:nmap <leader>s :Rstylesheet<Space>

" swap ; and :
nnoremap ; :
nnoremap ,; ;
"            NAVIGATION
"
"stronger then will
:nmap <up> <nop>
:nmap <down> <nop>
:nmap <left> <nop>
:nmap <right> <nop>
:nmap <leader>jk ;w
:nmap <leader>kjk ;wq
:imap jk ;w
:imap kjk ;wq
:imap qq 
:imap vv "+pa

:map <F7> :retab:%s/\s\+$//e:%s/\r//g
:map <F8> :%s/:\([^ ]*\)\(\s*\)=>/\1:/g

"reload vimrc
:map <leader><F5> :source $MYVIMRC:windo e:bufdo e
""" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
" 
" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-w>s <C-w>s:set relativenumber
nnoremap <C-w>v <C-w>v:set relativenumber
"better cursor moves for wrapped lines
nnoremap j gj
nnoremap k gk

:nmap <Space> :CtrlP
:nmap <F12> :set invnumber<CR>	
:map <F9> :Tabularize/\w:\zs/l0l1<CR>
:map <F10> :Tabularize/ =>/l0r1l1<CR>
:nmap <F11> :set ft=html<CR>
nmap <silent> ,/ :nohlsearch<CR>

:nmap <F2> :set fdm=expr:set fde=getline(v:lnum)=~'^\\s#'?1:getline(prevnonblank(v:lnum))=~'^\\s#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0

imap <buffer> <Leader>u <C-O>:call PhpInsertUse()<CR>
map <buffer> <Leader>u :call PhpInsertUse()<CR>

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
nnoremap <leader>n :call NumberToggle()<cr>

nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
let g:pdv_cfg_Package = ''
let g:pdv_cfg_Version = ''
let g:pdv_cfg_Author = ''
let g:pdv_cfg_Copyright = ''
let g:pdv_cfg_License = ''
