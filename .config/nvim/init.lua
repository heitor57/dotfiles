local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end
function reload_config()
  vim.cmd([[PackerSync]])
  vim.cmd([[PackerCompile]])
end

vim.cmd([[
let mapleader=" "
set number
set timeoutlen=100
set mouse=a
let maplocalleader = "\\"
set termguicolors     " enable true colors support
set clipboard=unnamedplus
set cursorline
set tabstop=2
set number
set hlsearch
set incsearch
set spelllang=en
"nnoremap <leader>ça :setlocal spell!<cr>
cnoremap <C-v> <C-r>+
nnoremap <nowait> <c-s> <cmd>w<cr>
inoremap <nowait> <c-s> <cmd>w<cr>
inoremap <nowait> <c-q> <cmd>w<cr>
nnoremap <nowait> <c-q> <cmd>q<cr>
autocmd BufWritePost init.lua lua reload_config()
map gn :bn<cr>
map gp :bp<cr>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
"nnoremap <Leader>. :w<CR>
"nnoremap <Leader>; :wa<CR>:qa!<CR>
"nmap <Leader>d :up<CR>:!sfdp -Tpng % -o %:r.png<CR><CR>
"nnoremap <leader>ev :e $MYVIMRC<cr>
"nnoremap <leader>sv :source $MYVIMRC<cr>
]])
return require('packer').startup({function()
  use {'wbthomason/packer.nvim',config=function()
    local wk = require("which-key")
    wk.register({p={name="Packer",s={"<cmd>PackerSync<cr>","Packer Sync"}}}, {prefix="<leader>"})
  end}
  use 'neovim/nvim-lspconfig'
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  use {'preservim/nerdcommenter',
  setup = function()
    vim.cmd([[
    let g:NERDCreateDefaultMappings=0
    ]])
  end
  ,config=function()
    vim.cmd([[
    filetype plugin on
    vmap <leader>/ <plug>NERDCommenterToggle
    nmap <leader>/ <plug>NERDCommenterToggle
    ]])
  end}
  use {'neovim/nvim-lspconfig',config=function()
  end}
  use {'kabouzeid/nvim-lspinstall',config=function()
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }
      buf_set_keymap('n', 'ga','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

      -- Set some keybinds conditional on server capabilities
      if client.resolved_capabilities.document_formatting then
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      elseif client.resolved_capabilities.document_range_formatting then
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
      end

      -- Set autocommands conditional on server_capabilities
      if client.resolved_capabilities.document_highlight then
	vim.api.nvim_exec([[
	augroup lsp_document_highlight
	autocmd! * <buffer>
	autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	augroup END
	]], false)
      end
    end

    -- Configure lua language server for neovim development
    local lua_settings = {
      Lua = {
	runtime = {
	  -- LuaJIT in the case of Neovim
	  version = 'LuaJIT',
	  path = vim.split(package.path, ';'),
	},
	diagnostics = {
	  -- Get the language server to recognize the `vim` global
	  globals = {'vim'},
	},
	workspace = {
	  -- Make the server aware of Neovim runtime files
	  library = {
	    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
	    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
	  },
	},
      }
    }

    -- config that activates keymaps and enables snippet support
    local function make_config()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.preselectSupport = true
      capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
      capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      capabilities.textDocument.completion.completionItem.deprecatedSupport = true
      capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
      capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
      capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
	  'documentation',
	  'detail',
	  'additionalTextEdits',
	},
      }
      return {
	-- enable snippet support
	capabilities = capabilities,
	-- map buffer local keybindings when the language server attaches
	on_attach = on_attach,
      }
    end

    -- lsp-install
    local function setup_servers()
      require'lspinstall'.setup()

      -- get all installed servers
      local servers = require'lspinstall'.installed_servers()
      -- ... and add manually installed servers
      table.insert(servers, "clangd")
      table.insert(servers, "sourcekit")

      for _, server in pairs(servers) do
	local config = make_config()

	-- language specific config
	if server == "lua" then
	  config.settings = lua_settings
	end
	if server == "sourcekit" then
	  config.filetypes = {"swift", "objective-c", "objective-cpp"}; -- we don't want c and cpp!
	end
	if server == "clangd" then
	  config.filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
	end

	require'lspconfig'[server].setup(config)
      end
    end

    setup_servers()
    -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
    require'lspinstall'.post_install_hook = function ()
      setup_servers() -- reload installed servers
      vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
    end
    local function lspSymbol(name, icon)
      vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefaul" .. name })
    end

    lspSymbol("Error", "")
    lspSymbol("Information", "")
    lspSymbol("Hint", "")
    lspSymbol("Warning", "")

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
	prefix = "",
	spacing = 0,
      },
      signs = true,
      underline = true,
      update_in_insert = false, -- update diagnostics insert mode
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
    })

    -- suppress error messages from lang servers
    vim.notify = function(msg, log_level, _opts)
      if msg:match "exit code" then
	return
      end
      if log_level == vim.log.levels.ERROR then
	vim.api.nvim_err_writeln(msg)
      else
	vim.api.nvim_echo({ { msg } }, true, {})
      end
    end
  end}

  -- Install nvim-cmp, and buffer source as a dependency

  use {'L3MON4D3/LuaSnip',config=function ()
    luasnip = require('luasnip')
    luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }
  end}
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-buffer",
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
      'L3MON4D3/LuaSnip', -- Snippets plugin
    },config=function()
      vim.o.completeopt = 'menuone,noselect'
      local luasnip = require 'luasnip'
      local cmp = require'cmp'
      cmp.setup {
	snippet = {
	  expand = function(args)
	    require('luasnip').lsp_expand(args.body)
	  end,
	},
	mapping = {
	  ['<C-p>'] = cmp.mapping.select_prev_item(),
	  ['<C-n>'] = cmp.mapping.select_next_item(),
	  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<C-e>'] = cmp.mapping.close(),
	  ['<CR>'] = cmp.mapping.confirm {
	    behavior = cmp.ConfirmBehavior.Replace,
	    select = true,
	  },
	  ['<Tab>'] = function(fallback)
	    if vim.fn.pumvisible() == 1 then
	      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
	    elseif luasnip.expand_or_jumpable() then
	      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
	    else
	      fallback()
	    end
	  end,
	  ['<S-Tab>'] = function(fallback)
	    if vim.fn.pumvisible() == 1 then
	      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
	    elseif luasnip.jumpable(-1) then
	      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
	    else
	      fallback()
	    end
	  end,
	},
	sources = {
	  { name = 'nvim_lsp' },
	  { name = 'luasnip' },
	  { name = "buffer" },
	  { name = "nvim_lua" },
	},
      }
    end}

    use {'projekt0n/github-nvim-theme',config=function()
      require('github-theme').setup()
    end}

    use {'tpope/vim-sleuth'}

    use {'kevinhwang91/rnvimr',config=function ()
      vim.cmd([[
      tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
      nnoremap <silent> <M-o> :RnvimrToggle<CR>
      tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
      ]])
    end}
    use {'ray-x/lsp_signature.nvim',config=function ()
      local present, lspsignature = pcall(require, "lsp_signature")
      if present then
	lspsignature.setup {
	  bind = true,
	  doc_lines = 2,
	  floating_window = true,
	  fix_pos = true,
	  hint_enable = true,
	  hint_prefix = " ",
	  hint_scheme = "String",
	  hi_parameter = "Search",
	  max_height = 22,
	  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
	  handler_opts = {
	    border = "single", -- double, single, shadow, none
	  },
	  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
	  padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
	}
      end
    end}

    use {'kdheepak/lazygit.nvim',config=function ()
    local wk = require("which-key")
    wk.register({g={name="Git",g={"<cmd>LazyGit<CR>","LazyGit"}}}, {prefix="<leader>"})
    end}

    use {'ctrlpvim/ctrlp.vim',config=function ()
      vim.cmd([[
      let g:ctrlp_map = '<c-p>'
      let g:ctrlp_cmd = 'CtrlP'
      ]])   	
    end}
  end, config={auto_reload_compiled = true}})
