runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#helptags()
execute pathogen#infect()

syntax on
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype

set autochdir
set number
set ruler
set hls is ic scs
set mouse=a
set background=dark
colorscheme solarized

" command-T options:
" caches every dirs, uses more memory.
let g:CommandTMaxCachedDirectories=0 
let g:CommandTWildIgnore=&wildignore . "*.pyc,venv/**"

imap kj <Esc> :w<CR>
nmap gb gT
nmap <C-x> :bd<CR>
nmap <Leader>v :tabe $MYVIMRC <CR>
"Ctrl+n to turn off highlighting
nmap <silent> <C-n> :noh<CR>
nmap <Leader>d ggOimport pdb; pdb.set_trace()<Esc>==:w<CR>

autocmd FileType python map <buffer> <Leader>8 :call Flake8()<CR>
