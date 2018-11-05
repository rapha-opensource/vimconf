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
set clipboard=unnamed " so you can use * as the buffer to copy into clipboard
set background=dark
if !has('gui_running')
  let g:solarized_termtrans=1
endif
colorscheme solarized

set tabstop=4
set shiftwidth=4
set expandtab

" with this, opening a file in the quickfix or location list
" will open a new tab or switch to the tab that has this buffer
set switchbuf+=usetab,newtab


" command-T options:
" caches every dirs, uses more memory.
let g:CommandTMaxCachedDirectories=0 
"let g:CommandTWildIgnore=&wildignore . "*/__pycache__/**,*.pyc,venv/**,*jpg,*.dg,*.svg,~/repo/react-app/node_modules/**,~/repo/react-app/build/**"
let g:CommandTWildIgnore="*.pyc,node_modules/**,build/**,img/**,font/**"

imap kj <Esc>:w<CR>
nmap gb gT
nmap <C-x> :bd<CR>
nmap <Leader>v :tabe $MYVIMRC <CR>
nmap <Leader>sv :source $MYVIMRC <CR>
"Ctrl+n to turn off highlighting
nmap <silent> <C-n> :noh<CR>
"set wildignore+=~/repo/api/venv/**,*.pyc
nmap <Leader>] :execute "vimgrep /" . expand("<cword>") . "/j **/*.py" <Bar> cw<CR>
vmap <Leader>= :w !pbcopy<CR><CR>
"nmap <Leader>' :s/#012/\r/g<CR>
nmap <Leader>( :s/(\(.*\))/(\r\1\r)<CR>
nmap <Leader>, :s/, /,\r/g<CR>

" ----- Python specific mapping --------------------------------------------------
" add a breakpoint in python
"autocmd FileType python nmap <Leader>d ggOimport pdb; pdb.set_trace()<Esc>==:w<CR>
" clear all breakpoints in python
"autocmd FileType python nmap <Leader>cbp :g/import pdb; pdb.set_trace/d<CR>:w<CR>

autocmd FileType python map <buffer> <Leader>8 :call Flake8()<CR>

" Javascript specific
"
" apply JSX syntax rules to JS files:
let g:jsx_ext_required = 0

" Search functions
"
" first redefine :grep
set grepprg=grep\ -rn

function! SearchAnyFiles(options, pattern, subdir)
    let git_root=system('git rev-parse --show-toplevel')
    execute "lgrep ".a:options." ".a:pattern." ".git_root.a:subdir
    lop
endfunction

function! FindInJSFiles()
    call inputsave()
    let pattern = input('Find in Javascript files: ')
    call inputrestore()
    call SearchJsFiles(l:pattern)
endfunction

function! FindInPyFiles()
    call inputsave()
    let pattern = input('Find in Python files: ')
    call inputrestore()
    call SearchPyFiles(l:pattern)
endfunction

function! FindInJavaFiles()
    call inputsave()
    let pattern = input('Find in Java files: ')
    call inputrestore()
    call SearchJavaFiles(l:pattern)
endfunction

function! FindInGoFiles()
    call inputsave()
    let pattern = input('Find in Go files: ')
    call inputrestore()
    call SearchXCoreGoFiles(l:pattern)
endfunction

function! SearchJsFiles(pattern)
    call SearchAnyFiles("--exclude bundle.js --include \\*.js --exclude-dir build --exclude-dir node-modules", a:pattern, "")
endfunction

function! SearchPyFiles(pattern)
    call SearchAnyFiles("--include \\*.py ", a:pattern, "")
endfunction

function! SearchJavaFiles(pattern)
    call SearchAnyFiles("--include \\*.java ", a:pattern, "/rebase")
endfunction

function! SearchGoServices(pattern)
    let git_root=system('git rev-parse --show-toplevel')
    execute "lgrep --include \\*.go ".a:pattern." ".git_root."/services"
    lop
endfunction

function! SearchGoLib(pattern)
    let l:git_root=system('git rev-parse --show-toplevel')."/lib/go/sr/xinova"
    execute "lgrep --include \\*.go ".a:pattern." ".l:git_root
    lop
endfunction

function! SearchXcoreGo(pattern)
    let git_root=system('git rev-parse --show-toplevel')
    execute "lgrep --include \\*.go ".a:pattern." ".git_root
    lop
endfunction

nmap <Leader>[ :call SearchPyFiles(expand('<cword>'))<CR><CR>
nmap <Leader>js :call SearchJsFiles(expand('<cword>'))<CR><CR>
nmap <Leader>jv :call SearchJavaFiles(expand('<cword>'))<CR><CR>
nmap <Leader>jxg :call SearchXcoreGo(expand('<cword>'))<CR><CR>
nmap <Leader>jgs :call SearchGoServices(expand('<cword>'))<CR><CR>
nmap <Leader>jgl :call SearchGoLib(expand('<cword>'))<CR><CR>
nmap <Leader>fjs :call FindInJSFiles()<CR><CR>
nmap <Leader>fjv :call FindInJavaFiles()<CR><CR>
nmap <Leader>fpy :call FindInPyFiles()<CR><CR>
nmap <Leader>fgo :call FindInGoFiles()<CR><CR>
nmap <Leader>gl :tabe ~/repos/xcore/lib/go/src/xinova<CR>
nmap <Leader>gs :tabe ~/repos/xcore/services<CR>
nmap <Leader>gx :tabe ~/repos/xcore<CR>
