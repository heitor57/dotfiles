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

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

call plug#begin('~/.vim/plugged')


Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone
"
"list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdTree'
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
 "let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
"let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
"let g:UltiSnipsRemoveSelectModeMappings = 0
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <C-h> :NERDTreeFind<cr>
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>
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
Plug 'kevinhwang91/rnvimr'
let g:rnvimr_enable_picker = 1
nnoremap <silent> <leader>f :RnvimrToggle<CR>
tnoremap <silent> <leader>f <C-\><C-n>:RnvimrToggle<CR>
"let g:rnvimr_layout = {
            "\ 'relative': 'editor',
            "\ 'width': float2nr(round(1.0 * &columns)),
            "\ 'height': float2nr(round(1.0 * &lines)),
            "\ 'col': float2nr(round(0.5 * &columns)),
            "\ 'row': float2nr(round(0.5 * &lines)),
            "\ 'style': 'minimal'
            "\ }
"Plug 'rbgrouleff/bclose.vim'
Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'
Plug 'mindriot101/vim-yapf'
:nnoremap <leader>y :call Yapf()<cr>
let g:yapf_style = "google"

"Plug 'Yggdroot/indentLine'
Plug 'lervag/vimtex'
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_compiler_latexmk_engines = {
												"\ '_'                : '-lualatex -shell-escape',
												\ '_'                : '-lualatex',
												\ 'pdflatex'         : '-pdf',
												\ 'dvipdfex'         : '-pdfdvi',
												\ 'lualatex'         : '-lualatex',
												\ 'xelatex'          : '-xelatex',
												\ 'context (pdftex)' : '-pdf -pdflatex=texexec',
												\ 'context (luatex)' : '-pdf -pdflatex=context',
												\ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
												\}
"if has('nvim') || has('patch-8.0.902')
  "Plug 'mhinz/vim-signify'
"else
  "Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
"endif
"Plug 'junegunn/vim-easy-align'
"" Start interactive EasyAlign in visual mode (e.g. vipga)
"xmap ga <Plug>(EasyAlign)

"" Start interactive EasyAlign for a motion/text object (e.g. gaip)
"nmap ga <Plug>(EasyAlign)

Plug 'godlygeek/tabular'
"Plug 'honza/vim-snippets'
"Plug 'aklt/plantuml-syntax'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
syntax on
set t_Co=256
let g:airline_theme='onehalfdark'
call plug#end()
colorscheme onehalfdark

nnoremap <Leader><Leader> :qa!<CR>
nnoremap <Leader>] :PlugInstall<CR>
map gn :bn<cr>
map gp :bp<cr>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <Leader>. :wa<CR>
nmap <Leader>d :up<CR>:!sfdp -Tpng % -o %:r.png<CR><CR>


 au InsertEnter * call ncm2#enable_for_buffer()
		au Filetype tex call ncm2#register_source({
				\ 'name' : 'vimtex-cmds',
				\ 'priority': 8, 
				\ 'complete_length': -1,
				\ 'scope': ['tex'],
				\ 'matcher': {'name': 'prefix', 'key': 'word'},
				\ 'word_pattern': '\w+',
				\ 'complete_pattern': g:vimtex#re#ncm2#cmds,
				\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
				\ })
		au Filetype tex call ncm2#register_source({
				\ 'name' : 'vimtex-labels',
				\ 'priority': 8, 
				\ 'complete_length': -1,
				\ 'scope': ['tex'],
				\ 'matcher': {'name': 'combine',
				\             'matchers': [
				\               {'name': 'substr', 'key': 'word'},
				\               {'name': 'substr', 'key': 'menu'},
				\             ]},
				\ 'word_pattern': '\w+',
				\ 'complete_pattern': g:vimtex#re#ncm2#labels,
				\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
				\ })
		au Filetype tex call ncm2#register_source({
				\ 'name' : 'vimtex-files',
				\ 'priority': 8, 
				\ 'complete_length': -1,
				\ 'scope': ['tex'],
				\ 'matcher': {'name': 'combine',
				\             'matchers': [
				\               {'name': 'abbrfuzzy', 'key': 'word'},
				\               {'name': 'abbrfuzzy', 'key': 'abbr'},
				\             ]},
				\ 'word_pattern': '\w+',
				\ 'complete_pattern': g:vimtex#re#ncm2#files,
				\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
				\ })
		au Filetype tex call ncm2#register_source({
				\ 'name' : 'bibtex',
				\ 'priority': 8, 
				\ 'complete_length': -1,
				\ 'scope': ['tex'],
				\ 'matcher': {'name': 'combine',
				\             'matchers': [
				\               {'name': 'prefix', 'key': 'word'},
				\               {'name': 'abbrfuzzy', 'key': 'abbr'},
				\               {'name': 'abbrfuzzy', 'key': 'menu'},
				\             ]},
				\ 'word_pattern': '\w+',
				\ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
				\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
				\ })
