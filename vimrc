runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#helptags()
execute pathogen#infect()

set runtimepath^=~/.vim/bundle/ctrlp.vim

syntax on
" try to detect filetypes
filetype on
" enable loading indent file for filetype
filetype plugin indent on

set hidden
"set autochdir
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
" uncomment the following for photogrammetry-js code...
autocmd Filetype javascript setlocal ts=4 sw=4 expandtab
autocmd Filetype html setlocal ts=4 sw=4 expandtab
autocmd Filetype matlab setlocal ts=2 sw=2 expandtab
"autocmd Filetype python setlocal ts=3 sw=3 expandtab

if has("autocmd")
    " If the filetype is Makefile then we need to use tabs
    " So do not expand tabs into space.
    autocmd FileType sh set noexpandtab
endif

" with this, opening a file in the quickfix or location list
" will open a new tab or switch to the tab that has this buffer
set switchbuf+=usetab,newtab

" ctrl-p options
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/extern/*

" -----  Command-T options ---------------------------------------------------------
" caches every dirs, uses more memory.
let g:CommandTMaxFiles=1000000
let g:CommandTMaxDepth=30
let g:CommandTMaxCachedDirectories=0 
let g:CommandTFileScanner="git"
"let g:CommandTWildIgnore=&wildignore . "*/__pycache__/**,*.pyc,venv/**,*jpg,*.dg,*.svg,~/repo/react-app/node_modules/**,~/repo/react-app/build/**"
let g:CommandTWildIgnore="*.pyc,**/node_modules/*,**/build/*,**/img/*,**/font/*"
" -----  Command-T options ---------------------------------------------------------


" --------  Shortcuts ------------------------------------------------------------
imap kj <Esc>:w<CR>
nmap gb gT
nmap <C-x> :bd<CR>
nmap <Leader>v :tabe $MYVIMRC <CR>
nmap <Leader>sv :source $MYVIMRC <CR>
"Ctrl+n to turn off highlighting
nmap <silent> <C-n> :noh<CR>
nmap <Leader>] :execute "vimgrep /" . expand("<cword>") . "/j **/*.py" <Bar> cw<CR>
vmap <Leader>= :w !pbcopy<CR><CR>
nmap <Leader>( :s/(\(.*\))/(\r\1\r)<CR>
nmap <Leader>, :s/, /,\r/g<CR>
nmap <Leader>" yiwciw"<C-R>""<ESC>
nmap <Leader>cwd :tabe `dirname %`<CR>
nmap <leader>gb :Gblame<CR>
" --------  Shortcuts ------------------------------------------------------------


" ----- Svelte specific stuff  ----------------------------------------------
let g:vim_svelte_plugin_load_full_syntax = 1
"au! BufNewFile,BufRead,BufReadPost *.svelte set filetype=html
let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_linters = {'svelte': ['stylelint', 'eslint']}
let g:ale_fixers = {'svelte': ['eslint', 'prettier', 'prettier_standard']}
" ----- Svelte specific stuff  ----------------------------------------------


" ----- Python specific mapping --------------------------------------------------
autocmd BufWritePre *.py execute ':Black'
" ----- Python specific mapping --------------------------------------------------


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
    call SearchXGo(l:pattern)
endfunction

function! FindInGit()
    call inputsave()
    let pattern = input('Find in Git files: ')
    call inputrestore()
    call SearchGgrep(l:pattern)
endfunction

function! SearchJsFiles(pattern)
    call SearchAnyFiles("--exclude bundle.js --include \\*.js --include \\*.svelte --exclude-dir build --exclude-dir node_modules", a:pattern, "")
endfunction

function! SearchPyFiles(pattern)
    call SearchAnyFiles("--include \\*.py ", a:pattern, "")
endfunction

function! SearchJavaFiles(pattern)
    call SearchAnyFiles("--include \\*.java ", a:pattern, "/rebase")
endfunction

function! SearchGgrep(pattern)
    execute "Ggrep ".a:pattern
    tab cwin
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
nmap <Leader>gg :call SearchGgrep(expand('<cword>'))<CR><CR>
nmap <Leader>fg :call FindInGit()<CR><CR>
nmap <Leader>xgl :call SearchGoLib(expand('<cword>'))<CR><CR>
nmap <Leader>fjs :call FindInJSFiles()<CR><CR>
nmap <Leader>fjv :call FindInJavaFiles()<CR><CR>
nmap <Leader>fpy :call FindInPyFiles()<CR><CR>
nmap <Leader>fgo :call FindInGoFiles()<CR><CR>
