if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

let mapleader=","
"let maplocalleader = ";"
set termguicolors     " enable true colors support
set clipboard=unnamedplus
set cursorline
set tabstop=2
set number
set hlsearch
set incsearch
set inccommand=nosplit
set foldmethod=indent
set nofoldenable

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

call plug#begin('~/.vim/plugged')
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone
" list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'scrooloose/nerdTree'
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <Leader>n :NERDTreeFind<cr>
let NERDTreeShowHidden=1

Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
nnoremap ,b :CtrlPBuffer<CR>
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"Plug 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
Plug 'preservim/nerdcommenter'
vmap <A-;> <plug>NERDCommenterToggle
nmap <A-;> <plug>NERDCommenterToggle
"Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
nnoremap <Leader>g :Git<CR>
nnoremap <Leader>p :Gpush<CR>
nnoremap <Leader>ç :Gpull<CR>
nnoremap <Leader>o :Glog<CR>
command -nargs=+ Ggr execute 'Ggrep' <q-args> | cw
nnoremap <Leader>a :Ggr 
Plug 'pedrohdz/vim-yaml-folds'
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
"Plug 'mileszs/ack.vim'
"
Plug 'rking/ag.vim'
nnoremap <Leader-q> :Ag 
let g:ag_working_path_mode="r"
"Plug 'tmhedberg/SimpylFold'
"let g:SimpylFold_docstring_preview = 1
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'
Plug 'mindriot101/vim-yapf'
:nnoremap <leader>y :call Yapf()<cr>
let g:yapf_style = "google"

Plug 'Yggdroot/indentLine'
Plug 'lervag/vimtex'
let g:vimtex_view_general_viewer = 'evince'
call plug#end()

nnoremap <Leader><Leader> :qa!<CR>
nnoremap <Leader>] :PlugInstall<CR>
map gn :bn<cr>
map gp :bp<cr>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <Leader>. :wa<CR>
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>:CtrlPClearCache<cr>
