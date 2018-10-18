call plug#begin('~/.vim/plugged')
"Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle'}  
Plug 'tpope/vim-fireplace', { 'for' : 'clojure'}
Plug 'arecarn/vim-crunch'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
set tabstop=4
set shiftwidth=4
map <C-n> :NERDTreeToggle<CR>
set encoding=utf-8
call plug#end()
set background=dark
set nu
set hlsearch
set incsearch
