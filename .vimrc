" Requirements: YouCompleteMe folder and run install.py
" Example of folder: ~/.vim/plugged/YouCompleteMe
" ./install.py

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fireplace', { 'for' : 'clojure'}
Plug 'arecarn/vim-crunch'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
" magit for vim
Plug 'jreybert/vimagit'
" fold improvaement
Plug 'tmhedberg/SimpylFold'
" indentation
Plug 'vim-scripts/indentpython.vim'
" Auto complete
Plug 'Valloric/YouCompleteMe'
" syntax checking
Plug 'vim-syntastic/syntastic'
" pep8
Plug 'nvie/vim-flake8'
" gui theme
"Plug 'jnurmine/Zenburn'
" terminal theme
"Plug 'altercation/vim-colors-solarized'
" Search anything from vim
Plug 'kien/ctrlp.vim'
" Git integration
Plug 'tpope/vim-fugitive'
call plug#end()
set tabstop=4
set shiftwidth=4
map <C-n> :NERDTreeToggle<CR>
set encoding=utf-8
set background=dark
set nu
set hlsearch
set incsearch

set foldmethod=indent
set foldlevel=99

nnoremap <space> za

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" let g:SimpylFold_docstring_preview=1

let g:ycm_autoclose_preview_window_after_completion=1
map <C-x>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" nmap <C-x>g :Magit<CR>
nmap <C-x>:!python tp2.py -i in.txt -o out.txt<CR>
nmap <C-x>b :!nvcc -ccbin clang-3.8 %:t -o %:r && ./%:r<CR>
nmap <C-x>ç :!nvcc %:t -o %:r && ./%:r<CR>



let python_highlight_all=1
syntax on


"if has('gui_running')
"  set background=dark
"  colorscheme solarized
"else
"  colorscheme zenburn
"endif
