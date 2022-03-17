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
  vim.cmd([[PackerInstall]])
  vim.cmd([[luafile $MYVIMRC]])
  vim.cmd[[PackerCompile]]
  --vim.cmd[[luafile $MYVIMRC]]
  vim.cmd([[PackerInstall]])
end
vim.cmd([[
function! LookUpDef()
    silent !clear
    execute "silent !xdg-open https://www.wordnik.com/words/" . expand('<cWORD>')
endfunction

let mapleader=" "
set timeoutlen=500
set mouse=a
let maplocalleader = "\\"
set clipboard=unnamedplus
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
map gn :bn<cr>
map gp :bp<cr>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
vnoremap > >gv
vnoremap < <gv
noremap <Up> gk
noremap <Down> gj

command! -nargs=* Dic call LookUpDef(<f-args>)

"autocmd BufWritePost init.lua lua reload_config()
"autocmd BufWritePost plugins.lua lua reload_config()
]])
local nvimrc = "~/.config/nvim"
vim.cmd('source ' .. nvimrc .. '/auxinit.vim')
--M.plugins = lua require('plugins')
M.plugins = require('plugins')
--
return M
