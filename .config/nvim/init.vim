if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

set cursorline
set tabstop=2
set number
set hlsearch
set incsearch
set inccommand=nosplit
set foldmethod=indent
set nofoldenable
"set foldexpr=VimFolds(v:lnum)
"set foldtext=MyFoldText()
"set fillchars=fold:\

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
nnoremap <C-n> :NERDTreeToggle<CR>
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
nnoremap <A-g> :Git<CR>
nnoremap <A-p> :Gpush<CR>
nnoremap <A-ç> :Gpull<CR>
nnoremap <A-l> :Glog<CR>
command -nargs=+ Ggr execute 'Ggrep' <q-args> | cw
nnoremap <A-a> :Ggr 
Plug 'pedrohdz/vim-yaml-folds'
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'ayu-theme/ayu-vim' " or other package manager
set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"Plug 'mileszs/ack.vim'
"
Plug 'king/ag.vim'
nnoremap <A-q> :Ag 
let g:ag_working_path_mode="r"
"Plug 'tmhedberg/SimpylFold'
"let g:SimpylFold_docstring_preview = 1
call plug#end()
colorscheme ayu
nnoremap , :qa!<CR>
nnoremap <A-]> :PlugInstall<CR>
map gn :bn<cr>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
"autocmd QuickFixCmdPost *grep* cwindow
