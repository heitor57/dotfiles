call plug#begin('~/.vim/plugged')
"Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}  
Plug 'tpope/vim-fireplace', { 'for' : 'clojure'}
Plug 'arecarn/vim-crunch'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
call plug#end()
set tabstop=4
set shiftwidth=4
map <C-n> :NERDTreeToggle<CR>
set encoding=utf-8
set background=dark
set nu
set hlsearch
set incsearch
