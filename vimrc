runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#helptags()
execute pathogen#infect()

syntax on
" try to detect filetypes
filetype on
" enable loading indent file for filetype
filetype plugin indent on

set autochdir
set number
set ruler
set hls is ic scs
set mouse=a
set background=dark
colorscheme solarized

set tabstop=4
set shiftwidth=4
set expandtab


" command-T options:
" caches every dirs, uses more memory.
let g:CommandTMaxCachedDirectories=0 
let g:CommandTWildIgnore=&wildignore . "*/__pycache__/**,*.pyc,venv/**,*jpg,*.dg,*.svg,~/repo/react-app/node_modules/**,~/repo/react-app/build/**"

imap kj <Esc>:w<CR>
nmap gb gT
nmap <C-x> :bd<CR>
nmap <Leader>v :tabe $MYVIMRC <CR>
"Ctrl+n to turn off highlighting
nmap <silent> <C-n> :noh<CR>
set wildignore+=~/repo/api/venv/**,*.pyc
nmap <Leader>] :execute "vimgrep /" . expand("<cword>") . "/j ~/repo/api/**/*.py" <Bar> cw<CR>
nmap <Leader>= :w !pbcopy<CR>

" ----- Python specific mapping --------------------------------------------------
" add a breakpoint in python
autocmd FileType python nmap <Leader>d ggOimport pdb; pdb.set_trace()<Esc>==:w<CR>
" clear all breakpoints in python
autocmd FileType python nmap <Leader>cbp :g/import pdb; pdb.set_trace/d<CR>:w<CR>

autocmd FileType python map <buffer> <Leader>8 :call Flake8()<CR>

" Javascript specific
"
" apply JSX syntax rules to JS files:
let g:jsx_ext_required = 0
