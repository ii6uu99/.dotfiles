filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
set nocompatible
set number
syntax on
filetype plugin indent on
:set mouse=a
:set ttymouse=xterm2
:set tags+=gems.tags

:set encoding=utf-8
:set fileencoding=utf-8
:set spelllang=pl,en
:set spell

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'bbommarito/vim-slim'
Bundle 'jpalardy/vim-slime'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'kana/vim-smartinput'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'sukima/xmledit'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'arnaud-lb/vim-php-namespace'

Bundle 'docteurklein/vim-symfony'
Bundle 'spf13/PIV'
Bundle 'mikehaertl/pdv-standalone'
Bundle 'hallettj/jslint.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tiokksar/vim-autotag'
Bundle 'scrooloose/nerdtree'

set tabstop=2
set shiftwidth=2
set shiftround
set showmatch
set expandtab
set autoindent
set copyindent
set ignorecase
set smartcase
set hlsearch
set incsearch
set history=1000         " remember more commands and search history
set undolevels=1000
set nobackup
set noswapfile
set backspace=indent,eol,start
colorscheme railscasts
set guifont=Terminus\ 9
let g:slime_target = "tmux"

"whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set guioptions-=T " remove the toolbar

"create directories if them dosent exists
augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END
function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Directory '" . required_dir . "' doesn't exist.", "&Create it?")

        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit("Can't create '" . required_dir . "'", "&Continue anyway?")
        endtry
    endif
endfunction

function! AskQuit (msg, proposed_action)
    if confirm(a:msg, a:proposed_action . "\n&Quit?") == 2 
        exit
    endif
endfunction

"cursor color"
if &term =~ "rxvt-unicode"
  "Set the cursor white in cmd-mode and orange in insert mode
  let &t_EI = "\<Esc>]12;white\x9c"
  let &t_SI = "\<Esc>]12;orange\x9c"
  "We normally start in cmd-mode
  silent !echo -e "\e]12;white\x9c"
endif

"folding"
set foldenable
set foldmethod=syntax
set foldlevel=8

autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype php setlocal ts=4 sts=4 sw=4

let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1

:set rnu
let g:ctrlp_user_command = 'find %s -type f \( ! -path "*/vendor/*" ! -path "*/cache/*" ! -path "*/cms/web/*" ! -path "*.git/*" ! -path "*/.*" ! -path "*/tmp/*" ! -name "*.so" ! -name "*.swp" ! -name "*.zip" ! -name "*.png" ! -name "*.jpg" ! -path "*/b/*" \)'
