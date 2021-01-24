if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

set number
set hlsearch
set incsearch
set inccommand=nosplit
call plug#begin('~/.vim/plugged')
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'scrooloose/nerdTree'
nmap <C-n> :NERDTreeToggle<CR>
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"Plug 'vim-airline/vim-airline-themes'
"let g:airline_theme='jellybeans'
Plug 'ayu-theme/ayu-vim'
set termguicolors     " enable true colors support
let ayucolor="mirage"  " for light version of theme
Plug 'preservim/nerdcommenter'
map <A-;> <plug>NERDCommenterToggle
"Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
map <C-a> :Git<CR>
call plug#end()
colorscheme ayu

