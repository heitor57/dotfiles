local M = {}
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end
function reload_config()
  --luafile $MYVIMRC
  require('plenary.reload').reload_module('plugins', true)
  require('plenary.reload').reload_module('init', true)
  vim.cmd([[luafile $MYVIMRC]])
  vim.cmd[[PackerCompile]]
  --vim.cmd[[luafile $MYVIMRC]]
  vim.cmd([[PackerInstall]])
end
vim.cmd([[
let mapleader=" "
set timeoutlen=500
set mouse=a
let maplocalleader = "\\"
""set termguicolors     " enable true colors support
set clipboard=unnamedplus
"set cursorline
set tabstop=2
set number
set hlsearch
set incsearch
set spelllang=pt_br
set confirm
nnoremap <leader>ça :setlocal spell!<cr>
cnoremap <C-v> <C-r>+
nnoremap <nowait> <c-s> <cmd>w<cr>
inoremap <nowait> <c-s> <cmd>w<cr>
inoremap <nowait> <c-q> <cmd>w<cr>
nnoremap <nowait> <c-q> <cmd>q<cr>
autocmd BufWritePost init.lua lua reload_config()
autocmd BufWritePost plugins.lua lua reload_config()
map gn :bn<cr>
map gp :bp<cr>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
"nnoremap <Leader>. :w<CR>
"nnoremap <Leader>; :wa<CR>:qa!<CR>
"nmap <Leader>d :up<CR>:!sfdp -Tpng % -o %:r.png<CR><CR>
"nnoremap <leader>ev :e $MYVIMRC<cr>
"nnoremap <leader>sv :source $MYVIMRC<cr>

function! LookUpDef()
    silent !clear
    execute "silent !xdg-open https://www.wordnik.com/words/" . expand('<cWORD>')
endfunction
command! -nargs=* Dic call LookUpDef(<f-args>)

vnoremap > >gv
vnoremap < <gv
"hi Normal guibg=NONE ctermbg=NONE
noremap <Up> gk
noremap <Down> gj
]])
local nvimrc = "~/.config/nvim"
vim.cmd('source ' .. nvimrc .. '/auxinit.vim')
--M.plugins = lua require('plugins')
M.plugins = require('plugins')
--
return M
