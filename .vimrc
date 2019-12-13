call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}
Plug 'tpope/vim-fireplace', { 'for' : 'clojure'}
Plug 'arecarn/vim-crunch'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'jreybert/vimagit'
call plug#end()
set tabstop=3
set shiftwidth=4
map <C-n> :NERDTreeToggle<CR>
set encoding=utf-8
set background=dark
set nu
set hlsearch
set incsearch

nmap <C-x>g :Magit<CR>
nmap <C-x>:!python tp2.py -i in.txt -o out.txt<CR>
nmap <C-x>b :!nvcc -ccbin clang-3.8 %:t -o %:r && ./%:r<CR>
nmap <C-x>ç :!nvcc %:t -o %:r && ./%:r<CR>
