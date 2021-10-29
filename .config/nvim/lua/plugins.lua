
return require('packer').startup({function()

	use {'voldikss/vim-translator',config=function ()
		vim.cmd([[
		let g:translator_target_lang='pt'
		]])
	end}
	use {'heitor57/vim-grammarous',config=function ()

		local wk = require("which-key")
		wk.register({w=
		{name='Grammarous',
		--n={"<cmd>NERDTreeFocus<cr>","NERDTreeFocus"},
		r={":'<, '>GrammarousCheck --lang=pt<cr>","Check Range"},
		--r={":'<, '>GrammarousCheck --lang=en<cr>"}
		a={":GrammarousCheck --lang=pt<cr>","Check Buffer"},
		f={"<Plug>(grammarous-fixit)","Fix"},
		--a={":GrammarousCheck --lang=en<cr>"
	}}, {prefix="<leader>"})
	--nmap <leader>çq <Plug>(grammarous-move-to-info-window)
	--" 	Open the info window for the error under the cursor
	--nmap <leader>çw <Plug>(grammarous-open-info-window)
	--" 	Reset the current check
	--nmap <leader>çe <Plug>(grammarous-reset)
	--" 	Fix the error under the cursor automatically
	--nmap <leader>çr <Plug>(grammarous-fixit)
	--" 	Fix all the errors in a current buffer automatically
	--nmap <leader>çt <Plug>(grammarous-fixall)
	--" 	Close the information window from checked buffer
	--nmap <leader>çy <Plug>(grammarous-close-info-window)
	--" 	Remove the error under the cursor
	--nmap <leader>çu <Plug>(grammarous-remove-error)
	--" 	Disable the grammar rule under the cursor
	--nmap <leader>çi <Plug>(grammarous-disable-rule)
	--" 	Move cursor to the next error
	--nmap <leader>ço <Plug>(grammarous-move-to-next-error)
	--" 	Move cursor to the previous error
	--nmap <leader>çp <Plug>(grammarous-move-to-previous-error)
end}
use {'lervag/vimtex',config=function ()
	vim.cmd([[
	let g:vimtex_compiler_latexmk_engines = { '_': '-lualatex -shell-escape'}
	]])
	--vim.cmd([[
	--let g:vimtex_compiler_latexmk_engines = { '_': '-xelatex -shell-escape'}
	--]])
	--vim.cmd([[
	--let g:vimtex_compiler_latexmk_engines = { '_': '-pdf -shell-escape'}
	--]])
end}
use {'preservim/nerdtree',config=function ()

	--local wk = require("which-key")
	--wk.register({e=
	--{name='Explorer',
	----nnoremap <C-n> :NERDTree<CR>
	----nnoremap <C-t> :NERDTreeToggle<CR>
	----nnoremap <C-f> :NERDTreeFind<CR>
	--e={"<cmd>NERDTree<cr>","NERDTree"},
	--t={"<cmd>NERDTreeToggle<cr>","NERDTreeToggle"},
	--f={"<cmd>NERDTreeFind<cr>","NERDTreeFind"},
	--n={"<cmd>NERDTreeFocus<cr>","NERDTreeFocus"},
	--}}, {prefix="<leader>"})
end}
use {
	'kyazdani42/nvim-tree.lua',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function() 
		require'nvim-tree'.setup {}
		local wk = require("which-key")
		wk.register({e=
		{name='Explorer',
		--nnoremap <C-n> :NERDTree<CR>
		--nnoremap <C-t> :NERDTreeToggle<CR>
		--nnoremap <C-f> :NERDTreeFind<CR>
		e={"<cmd>NvimTreeToggle<cr>","Toggle"},
		f={"<cmd>NvimTreeFindFile<cr>","Find"},
		r={"<cmd>NvimTreeRefresh<cr>","Refresh"},
		n={"<cmd>NvimTreeFocus<cr>","Focus"},
	}}, {prefix="<leader>"})

end
}
use {'heavenshell/vim-pydocstring',config=function ()
	vim.cmd([[
	let g:pydocstring_doq_path = '/home/heitor/.local/bin/doq'
	let g:pydocstring_formatter = 'google'
	]])
	local wk = require("which-key")
	wk.register({a=
	{
		d={"<cmd>Pydocstring<cr>","Python Doc String"},
	}}, {prefix="<leader>"})

	wk.register(
	{
		d={"<cmd>Pydocstring<cr>","Python Doc String"},
	}, {prefix="<leader>",mode='v'})

end}
use {'tpope/vim-fugitive',config=function ()

	local wk = require("which-key")
	wk.register({g=
	{
		f={"<cmd>G<cr>","Git Fugitive"},
		p={"<cmd>G! push<cr>","Push"},
		u={"<cmd>G! pull<cr>","Pull"},
	}}, {prefix="<leader>"})

end}
use {'tpope/vim-abolish'}
use {'vim-scripts/CmdlineComplete'}
use {'farmergreg/vim-lastplace'}
use {'tpope/vim-repeat'}
use {'mg979/vim-visual-multi'}
use {'matze/vim-move',config=function ()
	vim.cmd([[let g:move_key_modifier = 'C']])
end}
use {'tpope/vim-sensible'}
use {'nvim-lua/plenary.nvim'}
use 'kana/vim-smartinput'                
use {'wbthomason/packer.nvim',config=function()
	local wk = require("which-key")
	wk.setup(
	{
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
		spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints

		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
	}
	)
	wk.register({p=
	{name="Packer",
	s={"<cmd>PackerSync<cr>","Sync"},
	i={"<cmd>PackerInstall<cr>","Install"},
	c={"<cmd>PackerCompile<cr>","Compile"},
}}, {prefix="<leader>"})

end}
use {
	"folke/which-key.nvim",
	config = function()
		wk=require("which-key")
		wk.setup {}
		wk.register({a={name='General',
		c={'<cmd>e $MYVIMRC<cr>','Edit Config'},
	}}, {prefix="<leader>"})
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

	-- BEGIN OF LSP

	use {'neovim/nvim-lspconfig',config=function()
		vim.cmd([[set exrc]])
	end}
	use {'williamboman/nvim-lsp-installer',requires={'neovim/nvim-lspconfig'},config=function()
		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
			buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

			-- Mappings.
			local opts = { noremap=true, silent=true }
			buf_set_keymap('n', 'ga','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
			buf_set_keymap('n', 'go', '<Cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
			buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
			buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
			buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
			buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
			buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
			buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
			wk = require("which-key")
			wk.register({l={name="LSP",
			w={'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',"Add Workspace"},
			r={'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',"Remove Workspace"},
			l={'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',"List Workspaces"},
			t={'<cmd>lua vim.lsp.buf.type_definition()<CR>',"Type Definition"},
			r={'<cmd>lua vim.lsp.buf.rename()<CR>',"Rename"},
			o={'<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',"Loc List"},
			f={"<cmd>lua vim.lsp.buf.formatting()<CR>","Format"},
		}}, {prefix="<leader>"})
		--buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
		buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		--buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
		buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
		--buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

		-- Set some keybinds conditional on server capabilities
		--if client.resolved_capabilities.document_formatting then
		--buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		--elseif client.resolved_capabilities.document_range_formatting then
		--buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
		--end

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
		--"hrsh7th/vim-vsnip",
		--"hrsh7th/vim-vsnip-integ",
		"hrsh7th/cmp-buffer",
		'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
		'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
		'L3MON4D3/LuaSnip', -- Snippets plugin
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline'
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
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end,
				['<S-Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
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
				--{ name = "orgmode" },
			},
		}
		cmp.setup.cmdline('/', {
			sources = {
				{ name = 'buffer' }
			}
		})
		cmp.setup.cmdline(':', {
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})
	end}

	use {'projekt0n/github-nvim-theme',config=function()
		require('github-theme').setup()
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

	-- END OF LSP

	use {'tpope/vim-sleuth'}

	use {'kevinhwang91/rnvimr',config=function ()
		vim.cmd([[
		let g:rnvimr_enable_picker = 1
		tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
		nnoremap <silent> <M-o> :RnvimrToggle<CR>
		tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
		]])
	end}

	use {'kdheepak/lazygit.nvim',config=function ()
		local wk = require("which-key")
		wk.register({g={name="Git",g={"<cmd>LazyGit<CR>","LazyGit"}}}, {prefix="<leader>"})
	end}

	--use {'ctrlpvim/ctrlp.vim',config=function ()
		--vim.cmd([[
		--let g:ctrlp_map = '<c-p>'
		--let g:ctrlp_cmd = 'CtrlP'
		--let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
		--]])   	
		--end}
		--use {'sgur/ctrlp-extensions.vim',config=function ()
			--local wk = require("which-key")
			--wk.register({s={name='Search',
			--c={'<cmd>CtrlPCmdline<cr>','CtrlPCmdline'},
			--b={'<cmd>CtrlPBuffer<cr>','CtrlPBuffer'}}}, {prefix="<leader>"})
			--end}
			use {'mhinz/vim-grepper',config=function ()
				local wk = require("which-key")
				wk.register({s={g={'<cmd>Grepper<cr>','Grepper'}}},{prefix="<leader>"})
			end}
			use {'airblade/vim-rooter'}
			use {'gabrielpoca/replacer.nvim',config=function ()
				local wk = require("which-key")
				wk.register({a={r={':lua require("replacer").run()<cr>','Quickfix Replacer'}}},{prefix="<leader>"})
			end}
			--use {'tamton-aquib/staline.nvim',config=function ()
				--require('staline').setup{}
				--end}
				use {'sbdchd/neoformat',config=function ()
					local wk = require("which-key")
					wk.register({a={f={'<cmd>Neoformat<cr>','Format file'}}},{prefix="<leader>"})

					vim.cmd([[let g:neoformat_enabled_python = ['black', 'docformatter'] ]])
					vim.cmd([[
					let g:neoformat_tex_latexindent = {
						\ 'exe': 'latexindent',
						\ 'args': ['-l'],
						\ 'stdin': 1
						\ }
						]])
						--vim.cmd([[
						--augroup fmt
						--autocmd!
						--autocmd BufWritePre * undojoin | Neoformat
						--augroup END
						--]])
					end}
					use {'tpope/vim-unimpaired'}

					use 'moll/vim-bbye'
					use 'aymericbeaumet/vim-symlink'
					use 'AndrewRadev/bufferize.vim'
					use {'tanvirtin/monokai.nvim',config=function ()
						require('monokai')
						vim.cmd('colorscheme monokai')
					end}
					use {'nvim-lua/lsp-status.nvim', requires='neovim/nvim-lspconfig', config=function ()
						local lsp_status = require('lsp-status')
						lsp_status.register_progress()
						local lspconfig = require('lspconfig')
						lspconfig.clangd.setup({
							handlers = lsp_status.extensions.clangd.setup(),
							init_options = {
								clangdFileStatus = true
							},
							on_attach = lsp_status.on_attach,
							capabilities = lsp_status.capabilities
						})

						--lspconfig.pyls_ms.setup({
							--handlers = lsp_status.extensions.pyls_ms.setup(),
							--settings = { python = { workspaceSymbols = { enabled = true }}},
							--on_attach = lsp_status.on_attach,
							--capabilities = lsp_status.capabilities
							--})

							lspconfig.ghcide.setup({
								on_attach = lsp_status.on_attach,
								capabilities = lsp_status.capabilities
							})
							lspconfig.rust_analyzer.setup({
								on_attach = lsp_status.on_attach,
								capabilities = lsp_status.capabilities
							})
						end
					}

					use {
						'hoob3rt/lualine.nvim',
						requires = {{'kyazdani42/nvim-web-devicons', opt = true},{'nvim-lua/lsp-status.nvim'}},
						config=function ()
							require'lualine'.setup {
								options = {
									icons_enabled = true,
									theme = 'horizon',
									component_separators = {'', ''},
									section_separators = {'', ''},
									disabled_filetypes = {}
								},
								sections = {
									lualine_a = {'mode'},
									lualine_b = {'branch'},
									lualine_c = {'filename'},
									lualine_x = {require'lsp-status'.status,'encoding' ,'fileformat', 'filetype'},
									lualine_y = {'progress'},
									lualine_z = {'location'}
								},
								inactive_sections = {
									lualine_a = {},
									lualine_b = {},
									lualine_c = {'filename'},
									lualine_x = {'location'},
									lualine_y = {},
									lualine_z = {}
								},
								tabline = {},
								extensions = {}
							}
						end
					}


					use {
						"nvim-telescope/telescope-frecency.nvim",
						config = function()
							require"telescope".load_extension("frecency")
							local wk = require("which-key")
							wk.register({t={name='Telescope',
							r={'<cmd>Telescope frecency<cr>','Buffers'}}}, {prefix="<leader>"})
						end,
						requires = {"tami5/sqlite.lua"}
					}
					use {
						'nvim-telescope/telescope.nvim',
						requires = { 'nvim-lua/plenary.nvim' ,'nvim-telescope/telescope-project.nvim'},
						config=function ()
							require'telescope'.load_extension('project')
							require("telescope").setup({defaults = { file_ignore_patterns = {"node_modules",'.git/','.vscode/'} } })
							local wk = require("which-key")
							wk.register({t={name='Telescope',
							f={'<cmd>Telescope find_files<cr>','Find files'},
							c={'<cmd>Telescope commands<cr>','Commands'},
							p={":lua require'telescope'.extensions.project.project{}<CR>",'Projects'},
							b={'<cmd>Telescope buffers<cr>','Buffers'}}}, {prefix="<leader>"})

							vim.cmd[[
							noremap <c-p> <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>
							]]
						end
					}
					use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate',config=function ()
						require'nvim-treesitter.configs'.setup {
							ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
							ignore_install = { "javascript" }, -- List of parsers to ignore installing
							highlight = {
								enable = true,              -- false will disable the whole extension
								disable = { "rust" },  -- list of language that will be disabled
								-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
								-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
								-- Using this option may slow down your editor, and you may see some duplicate highlights.
								-- Instead of true it can also be a list of languages
								additional_vim_regex_highlighting = false,
							},
						}
					end}
					use {'neomake/neomake'}

					--use {'kristijanhusak/orgmode.nvim', config = function()
						--require('orgmode').setup{}
						--end
						--}
						use {'glepnir/dashboard-nvim',config=function ()

							vim.cmd[[let g:dashboard_default_executive ='telescope']]
						end}
						--use {'gpanders/vim-oldfiles'}
						use {
							'lewis6991/gitsigns.nvim',
							requires = {
								'nvim-lua/plenary.nvim'
							},
							config = function()
								require('gitsigns').setup({})
							end
						}
						use {'skywind3000/asynctasks.vim',requires={'skywind3000/asyncrun.vim','GustavoKatel/telescope-asynctasks.nvim'},config=function ()
							vim.cmd([[
							let g:asyncrun_open = 6
							]])


							local wk = require("which-key")
							wk.register({t={
								t={require('telescope').extensions.asynctasks.all,'Tasks'}}}, {prefix="<leader>"})
							end}


							use {'mfussenegger/nvim-dap',config=function ()
								local dap = require('dap')
								dap.adapters.lldb = {
									type = 'executable',
									command = '/usr/bin/lldb-vscode',
									name = "lldb"
								}
								dap.configurations.cpp = {
									{
										name = "Launch",
										type = "lldb",
										request = "launch",
										program = function()
											return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
										end,
										cwd = '${workspaceFolder}',
										stopOnEntry = false,
										args = {},
										runInTerminal = false,
									},
								}
								dap.configurations.c = dap.configurations.cpp
							end}
							use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
							--use {'neoclide/coc.nvim', branch='release',config=function ()
								--vim.cmd('source ~/.config/nvim/cocnvim.vim')
								--end}
								--
								local wk = require("which-key")
								wk.register({d=
								{name='DAP',
								c={":lua require'dap'.continue()<CR>","Continue"},
								s={":lua require'dap'.step_over()<CR>","Step over"},
								i={":lua require'dap'.step_into()<CR>","Step into"},
								o={":lua require'dap'.step_out()<CR>","Step out"},
								b={":lua require'dap'.toggle_breakpoint()<CR>","Toggle Breakpoint"},
								n={":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>","Set condition Breakpoint"},
								m={":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>","log point Breakpoint"},
								r={":lua require'dap'.repl.open()<CR>","Relp open"},
								l={":lua require'dap'.run_last()<CR>","run last"},
								g={name="DAP UI",
								o={':lua require("dapui").open()<cr>',"Open"},
								c={':lua require("dapui").close()<cr>',"Close"},
								t={':lua require("dapui").toggle()<cr>',"Toggle"},
								s={':lua require("dapui").setup()<cr>',"Setup"},
							}
						}}, {prefix="<leader>"})
						use {"akinsho/toggleterm.nvim",config=function ()
							require("toggleterm").setup{}
						end}
						use{'rmagatti/auto-session'}
					end, config={auto_reload_compiled = true}})
