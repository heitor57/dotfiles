set hlsearch
set incsearch
call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
call plug#end()
map <C-n> :NERDTreeToggle<CR>
colorscheme solarized
set background=dark
