if exists('g:vscode')
  let mapleader=","
  set number
  set incsearch
  set hlsearch
  set clipboard=unnamedplus
  vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
  nnoremap <leader>ev :e $MYVIMRC<cr>
  nnoremap <leader>sv :source $MYVIMRC<cr>
  nnoremap <Leader>. :wa<CR>
  nnoremap <Leader>; :wa<CR>:qa!<CR>
  call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
  Plug 'preservim/nerdcommenter'
  vmap <leader>ç <plug>NERDCommenterToggle
  nmap <leader>ç <plug>NERDCommenterToggle
  call plug#end()
else
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  let mapleader=","
  let maplocalleader = "\\"
  set termguicolors     " enable true colors support
  set clipboard=unnamedplus
  set cursorline
  set tabstop=2
  set number
  set hlsearch
  set incsearch
  set inccommand=nosplit
  set pumblend=20
  set winblend=20
  cnoremap <C-v> <C-r>+
  abbr ref \textbf{[REF]}
  vnoremap <leader>w :'<, '>GrammarousCheck --lang=en<cr>
  nnoremap <leader>w :'<, '>GrammarousCheck --lang=en<cr>
  "set foldexpr=1
  set foldmethod=expr
  "set foldlevelstart=99
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-bibtex.nvim'
  

  Plug 'iamcco/markdown-preview.nvim'
  Plug 'fatih/vim-go'
  Plug 'tpope/vim-abolish'

  Plug 'voldikss/vim-translator'
  let g:translator_target_lang='pt'
  "Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'vim-pandoc/vim-rmarkdown'

  " language tool
  Plug 'heitor57/vim-grammarous'
  "nmap <leader>çn <Plug>(grammarous-move-to-next-error)
  "let g:grammarous#convert_char_to_byte=1

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "  Move the cursor to the info window
  nmap <leader>çq <Plug>(grammarous-move-to-info-window)
  " 	Open the info window for the error under the cursor
  nmap <leader>çw <Plug>(grammarous-open-info-window)
  " 	Reset the current check
  nmap <leader>çe <Plug>(grammarous-reset)
  " 	Fix the error under the cursor automatically
  nmap <leader>çr <Plug>(grammarous-fixit)
  " 	Fix all the errors in a current buffer automatically
  nmap <leader>çt <Plug>(grammarous-fixall)
  " 	Close the information window from checked buffer
  nmap <leader>çy <Plug>(grammarous-close-info-window)
  " 	Remove the error under the cursor
  nmap <leader>çu <Plug>(grammarous-remove-error)
  " 	Disable the grammar rule under the cursor
  nmap <leader>çi <Plug>(grammarous-disable-rule)
  " 	Move cursor to the next error
  nmap <leader>ço <Plug>(grammarous-move-to-next-error)
  " 	Move cursor to the previous error
  nmap <leader>çp <Plug>(grammarous-move-to-previous-error)

  " Set internal encoding of vim, not needed on neovim, since coc.nvim using some
  " unicode characters in the file autoload/float.vim
  set encoding=utf-8

  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  "

  "inoremap <silent><expr> <TAB>
        "\ pumvisible() ? coc#_select_confirm() :
        "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        "\ <SID>check_back_space() ? "\<TAB>" :
        "\ coc#refresh()

  imap <C-l> <Plug>(coc-snippets-expand)
  vmap <C-j> <Plug>(coc-snippets-select)
  let g:coc_snippet_next = '<c-j>'
  let g:coc_snippet_prev = '<c-k>'
  imap <C-j> <Plug>(coc-snippets-expand-jump)
  xmap <leader>x  <Plug>(coc-convert-snippet)
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

  "Plug 'SirVer/ultisnips'
  Plug 'scrooloose/nerdTree'
  "inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

  " c-j c-k for moving in snippet
   "let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
  "let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
  "let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
  "let g:UltiSnipsRemoveSelectModeMappings = 0
  nnoremap <C-n> :NERDTreeToggle<cr>
  nnoremap <C-h> :NERDTreeFind<cr>
  nmap <Leader>m :NERDTreeFocus<cr>R<c-w><c-p>
  let NERDTreeShowHidden=1

  Plug 'tpope/vim-surround'
  Plug 'ctrlpvim/ctrlp.vim'
  nnoremap ,b :CtrlPBuffer<CR>
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  Plug 'sgur/ctrlp-extensions.vim'
  nnoremap ,c :CtrlPCmdline<CR>

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
  nnoremap <Leader>e :Git<CR>
  nnoremap <Leader>p :G push<CR>
  nnoremap <Leader>ç :G pull<CR>
  nnoremap <Leader>o :Glog<CR>
  "command! -nargs=+ Ggr execute 'Ggrep' <q-args> | cw
  "nnoremap <Leader>a :Ggr 
  Plug 'pedrohdz/vim-yaml-folds'
  Plug 'airblade/vim-rooter'
  Plug 'mhinz/vim-startify'
  "
  "Plug 'rking/ag.vim'
  "let g:ag_working_path_mode="r"
  "
  "
  Plug 'mhinz/vim-grepper'
  nnoremap <Leader>q :Grepper<CR> 
  "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  "Plug 'junegunn/fzf.vim'
  "command! -bang -nargs=* FzfAg                              
    "\ call fzf#vim#ag(<q-args>,
    "\                 '--hidden --ignore .git',
    "\                 <bang>0 ? fzf#vim#with_preview('up:60%')
    "\                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    "\                 <bang>0)
  "let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  "nnoremap <Leader>q :FzfAg 
  "nmap <leader><tab> <plug>(fzf-maps-n)

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
  let g:vimtex_fold_enabled = 1
  autocmd User VimtexEventInitPost call SetVimTexFolder()
  function SetVimTexFolder()
      g:vimtex#fold#init_buffer()
      setlocal foldlevel=0
  endfunction
  "let g:vimtex_fold_manual = 1
  let g:vimtex_compiler_latexmk_engines = {
        "\ '_'                : '-xelatex -shell-escape',
        "\ '_'                : '-lualatex -shell-escape',
        \ '_'                : '-pdf -shell-escape',
        "\ '_'                : '-lualatex',
        "\ '_'                : '-lualatex',
        \ 'pdflatex'         : '-pdf',
        \ 'dvipdfex'         : '-pdfdvi',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}

  Plug 'godlygeek/tabular'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  "Plug 'sonph/onehalf', { 'rtp': 'vim' }
  "let g:airline_theme='onehalfdark'
  Plug 'cespare/vim-toml'
  Plug 'tpope/vim-sleuth'
  "let g:rehash256 = 1
  Plug 'moll/vim-bbye' " optional dependency
  Plug 'aymericbeaumet/vim-symlink'
  Plug 'skywind3000/asyncrun.vim'
  let g:asyncrun_open = 6
  Plug 'zhimsel/vim-stay'
  Plug 'pseewald/vim-anyfold'
  autocmd Filetype yaml AnyFoldActivate
  autocmd Filetype yaml setlocal foldlevel=1

  Plug 'sheerun/vim-polyglot'
  Plug 'Pocco81/Catppuccino.nvim'
  Plug 'tpope/vim-rsi'
  call plug#end()

lua << EOF
local catppuccino = require("catppuccino")
catppuccino.setup({colorscheme = "catppuccino"})
catppuccino.load()
EOF
  nnoremap <Leader><Leader> :qa!<CR>
  nnoremap <Leader>] :PlugInstall<CR>
  map gn :bn<cr>
  map gp :bp<cr>
  vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
  nnoremap <Leader>. :wa<CR>
  nnoremap <Leader>; :wa<CR>:qa!<CR>
  nmap <Leader>d :up<CR>:!sfdp -Tpng % -o %:r.png<CR><CR>
  nnoremap <leader>ev :e $MYVIMRC<cr>
  nnoremap <leader>sv :source $MYVIMRC<cr>
  "inoremap jk <esc>
  "inoremap <esc> <nop>
  onoremap p i(
  
  function! DeleteFileSwaps()
      write
      let l:output = ''
      redir => l:output 
      silent exec ':sw' 
      redir END 
      let l:current_swap_file = substitute(l:output, '\n', '', '')
      let l:base = substitute(l:current_swap_file, '\v\.\w+$', '', '')
      let l:swap_files = split(glob(l:base.'\.s*'))
      " delete all except the current swap file
      for l:swap_file in l:swap_files
          if !empty(glob(l:swap_file)) && l:swap_file != l:current_swap_file 
              call delete(l:swap_file)
              echo "swap file removed: ".l:swap_file
          endif
      endfor
      " Reset swap file extension to `.swp`.
      set swf! | set swf!
      echo "Reset swap file extension for file: ".expand('%')
  endfunction
  command! DeleteFileSwaps :call DeleteFileSwaps()
  "endif
	lua require"telescope".load_extension("bibtex")
  "autocmd FileType tex setlocal foldmethod=expr
  "autocmd FileType tex setlocal foldexpr=vimtex#fold#level(v:lnum)
  "autocmd FileType tex setlocal foldtext=vimtex#fold#text()
endif
