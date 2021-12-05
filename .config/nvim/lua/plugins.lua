function TableConcat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end
return require("packer").startup(
    {
        function()
            use {
                "voldikss/vim-translator",
                config = function()
                    vim.cmd([[
		let g:translator_target_lang='pt'
		]])
                end
            }
            use {
                "heitor57/vim-grammarous",
                config = function()
                    local wk = require("which-key")
                    wk.register(
                        {
                            w = {
                                name = "Grammarous",
                                --n={"<cmd>NERDTreeFocus<cr>","NERDTreeFocus"},
                                r = {":'<, '>GrammarousCheck --lang=pt<cr>", "Check Range"},
                                --r={":'<, '>GrammarousCheck --lang=en<cr>"}
                                a = {":GrammarousCheck --lang=pt<cr>", "Check Buffer"},
                                f = {"<Plug>(grammarous-fixit)", "Fix"}
                                --a={":GrammarousCheck --lang=en<cr>"
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }
            use {
                "lervag/vimtex",
                config = function()
                    vim.cmd([[
	let g:vimtex_compiler_latexmk_engines = { '_': '-pdflatex -shell-escape'}
	]])
                end
            }
            use {
                "kyazdani42/nvim-tree.lua",
                requires = "kyazdani42/nvim-web-devicons",
                config = function()
                    require "nvim-tree".setup {}
                    local wk = require("which-key")
                    wk.register(
                        {
                            e = {
                                name = "Explorer",
                                e = {"<cmd>NvimTreeToggle<cr>", "Toggle"},
                                f = {"<cmd>NvimTreeFindFile<cr>", "Find"},
                                r = {"<cmd>NvimTreeRefresh<cr>", "Refresh"},
                                n = {"<cmd>NvimTreeFocus<cr>", "Focus"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }
            use {
                "heavenshell/vim-pydocstring",
                config = function()
                    vim.cmd(
                        [[
	let g:pydocstring_doq_path = '/home/heitor/.local/bin/doq'
	let g:pydocstring_formatter = 'google'
	]]
                    )
                    local wk = require("which-key")
                    wk.register(
                        {
                            a = {
                                d = {"<cmd>Pydocstring<cr>", "Python Doc String"}
                            }
                        },
                        {prefix = "<leader>"}
                    )

                    wk.register(
                        {
                            d = {"<cmd>Pydocstring<cr>", "Python Doc String"}
                        },
                        {prefix = "<leader>", mode = "v"}
                    )
                end
            }
            use {
                "tpope/vim-fugitive",
                config = function()
                    local wk = require("which-key")
                    wk.register(
                        {
                            g = {
                                f = {"<cmd>G<cr>", "Git Fugitive"},
                                p = {"<cmd>G! push<cr>", "Push"},
                                u = {"<cmd>G! pull<cr>", "Pull"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }
            use {"tpope/vim-abolish"}
            use {"vim-scripts/CmdlineComplete"}
            use {"farmergreg/vim-lastplace"}
            use {"tpope/vim-repeat"}
            use {"mg979/vim-visual-multi"}
            use {
                "matze/vim-move",
                config = function()
                    vim.cmd([[let g:move_key_modifier = 'C']])
                end
            }
            use {"tpope/vim-sensible"}
            use {"nvim-lua/plenary.nvim"}
            use {
                "wbthomason/packer.nvim",
                config = function()
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
                                g = true -- bindings for prefixed with g
                            },
                            spelling = {enabled = true, suggestions = 20}, -- use which-key for spelling hints
                            hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "} -- hide mapping boilerplate
                        }
                    )
                    wk.register(
                        {
                            p = {
                                name = "Packer",
                                s = {"<cmd>PackerSync<cr>", "Sync"},
                                i = {"<cmd>PackerInstall<cr>", "Install"},
                                c = {"<cmd>PackerCompile<cr>", "Compile"},
                                l = {"<cmd>PackerClean<cr>", "Clean"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }
            use {
                "folke/which-key.nvim",
                config = function()
                    local wk = require("which-key")
                    wk.setup {}
                    wk.register(
                        {
                            a = {
                                name = "General",
                                c = {"<cmd>e $MYVIMRC<cr>", "Edit Config"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }
            use {
                "preservim/nerdcommenter",
                setup = function()
                    vim.cmd([[
		let g:NERDCreateDefaultMappings=0
		]])
                end,
                config = function()
                    vim.cmd(
                        [[
		filetype plugin on
		vmap <leader>/ <plug>NERDCommenterToggle
		nmap <leader>/ <plug>NERDCommenterToggle
		]]
                    )
                end
            }

            -- BEGIN OF LSP

            use {
                "neovim/nvim-lspconfig",
                config = function()
                end
            }
            use {
                "williamboman/nvim-lsp-installer",
                requires = {"neovim/nvim-lspconfig"},
                config = function()
                    local on_attach = function(client, bufnr)
                        local function buf_set_keymap(...)
                            vim.api.nvim_buf_set_keymap(bufnr, ...)
                        end
                        local function buf_set_option(...)
                            vim.api.nvim_buf_set_option(bufnr, ...)
                        end
                        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

                        -- Mappings.
                        local opts = {noremap = true, silent = true}
                        buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                        buf_set_keymap("n", "go", "<Cmd>lua vim.lsp.buf.document_highlight()<CR>", opts)
                        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                        buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                        buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                        buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
                        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                        local wk = require("which-key")
                        wk.register(
                            {
                                l = {
                                    name = "LSP",
                                    w = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace"},
                                    --r={'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',"Remove Workspace"},
                                    l = {
                                        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                                        "List Workspaces"
                                    },
                                    t = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition"},
                                    r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
                                    o = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Loc List"},
                                    f = {"<cmd>lua vim.lsp.buf.formatting()<CR>", "Format"}
                                }
                            },
                            {prefix = "<leader>"}
                        )
                        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                        buf_set_keymap("n", "g?", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
                        buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
                        buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
                        if client.resolved_capabilities.document_highlight then
                            vim.api.nvim_exec(
                                [[
			augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
			]],
                                false
                            )
                        end
                    end

                    local function make_config()
                        local capabilities = vim.lsp.protocol.make_client_capabilities()
                        capabilities.textDocument.completion.completionItem.documentationFormat = {
                            "markdown",
                            "plaintext"
                        }
                        capabilities.textDocument.completion.completionItem.snippetSupport = true
                        capabilities.textDocument.completion.completionItem.preselectSupport = true
                        capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
                        capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
                        capabilities.textDocument.completion.completionItem.deprecatedSupport = true
                        capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
                        capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
                        capabilities.textDocument.completion.completionItem.resolveSupport = {
                            properties = {
                                "documentation",
                                "detail",
                                "additionalTextEdits"
                            }
                        }
                        return {
                            -- enable snippet support
                            capabilities = capabilities,
                            -- map buffer local keybindings when the language server attaches
                            on_attach = on_attach
                        }
                    end

                    local lsp_installer = require("nvim-lsp-installer")

                    lsp_installer.on_server_ready(
                        function(server)
                            local config = make_config()
                            --vim.cmd([[echo ]] .. 	table.toString server)

                            if server.name == "clangd" then
                                config.filetypes = {"c", "cpp"} -- we don't want objective-c and objective-cpp!
                            end

                            --print(vim.inspect(server.name))
                            --print(vim.inspect(server.name == "ltex"))
                            --print(vim.inspect(server == "ltex"))
                            if server.name == "ltex" then
                                --vim.cmd([[echo 'texlab']])
                                --config.filetypes = {"text"}; -- we don't want objective-c and objective-cpp!
                                --config.settings = {ltex={additionalRules={motherTongue="pt-BR", languageModel="pt-BR"}}}
                                config.settings = {ltex = {language = "pt"}}
                            --print(vim.inspect(server.name == "ltex"))
                            --print(vim.inspect(config.settings))
                            --config.settings = {["ltex.additionalRules.motherTongue"]="pt-BR"}
                            --config.settings = {["ltex.additionalRules.languageModel"]="pt-BR"}
                            end

                            if server.name == "yamlls" then
                                config.filetypes = {"yaml"}
                            --config.on_init = function(client)
                            --local tmp = '/home/' .. vim.cmd[[echo $USER]] .. '/.config/nvim/schemas/swagger.yaml'
                            --print(vim.inspect(tmp))
                            --config.settings={yaml={schemas={['swagger-2.0']='swagger.yaml'},schemaDownload = {  enable = true },validate = true,trace={server='verbose'}}}
                            --print(vim.inspect(config.settings))
                            --client.notify("workspace/didChangeConfiguration")
                            --return true
                            --end
                            end

                            server:setup(config)

                            vim.cmd [[ do User LspAttachBuffers ]]
                        end
                    )

                    local function lspSymbol(name, icon)
                        vim.fn.sign_define(
                            "LspDiagnosticsSign" .. name,
                            {text = icon, numhl = "", texthl = "LspDiagnosticsSign" .. name}
                        )
                        --vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefault" .. name })
                    end

                    lspSymbol("Error", "")
                    lspSymbol("Information", "")
                    lspSymbol("Hint", "")
                    lspSymbol("Warning", "")
                    --lspSymbol("Warning", "X")

                    vim.lsp.handlers["textDocument/publishDiagnostics"] =
                        vim.lsp.with(
                        vim.lsp.diagnostic.on_publish_diagnostics,
                        {
                            virtual_text = {
                                prefix = "",
                                spacing = 0
                            },
                            signs = true,
                            underline = true,
                            update_in_insert = false -- update diagnostics insert mode
                        }
                    )
                    vim.lsp.handlers["textDocument/hover"] =
                        vim.lsp.with(
                        vim.lsp.handlers.hover,
                        {
                            border = "single"
                        }
                    )
                    vim.lsp.handlers["textDocument/signatureHelp"] =
                        vim.lsp.with(
                        vim.lsp.handlers.signature_help,
                        {
                            border = "single"
                        }
                    )

                    -- suppress error messages from lang servers
                    vim.notify = function(msg, log_level, _opts)
                        if msg:match "exit code" then
                            return
                        end
                        if log_level == vim.log.levels.ERROR then
                            vim.api.nvim_err_writeln(msg)
                        else
                            vim.api.nvim_echo({{msg}}, true, {})
                        end
                    end
                end
            }

            -- Install nvim-cmp, and buffer source as a dependency

            use {
                "L3MON4D3/LuaSnip",
                config = function()
                    local luasnip = require("luasnip")
                    luasnip.config.set_config {
                        history = true,
                        updateevents = "TextChanged,TextChangedI"
                    }
                    --local ls = require("luasnip")
                    --local s = ls.snippet
                    --local sn = ls.snippet_node
                    --local t = ls.text_node
                    --local i = ls.insert_node
                    --local f = ls.function_node
                    --local c = ls.choice_node
                    --local d = ls.dynamic_node
                    --local l = require("luasnip.extras").lambda
                    --local r = require("luasnip.extras").rep
                    ----local p = requireluasnip.extras").partial
                    --local m = require("luasnip.extras").match
                    --local n = require("luasnip.extras").nonempty
                    --local dl = require("luasnip.extras").dynamic_lambda
                    --local fmt = require("luasnip.extras.fmt").fmt
                    --local fmta = require("luasnip.extras.fmt").fmta
                    --local types = require("luasnip.util.types")
                    --local conds = require("luasnip.extras.expand_conditions")
                    ----luasnip.snippets.all = TableConcat(luasnip.snippets.all,{
                    ----s({trig="trigger"}, {})
                    ----s("trigger", {
                    ----t({[[\begin{figure}
                    ----\includegraphics[width=0.95\linewidth]]]}), i(1),
                    ----t({[[\caption{}
                    ----\end{figure}]]})
                    ----})
                end
            }
            use {
                "petertriho/cmp-git",
                requires = {"nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp"}
            }
            use {
                "hrsh7th/nvim-cmp",
                requires = {
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
                    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
                    "L3MON4D3/LuaSnip", -- Snippets plugin
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-cmdline",
                    "hrsh7th/cmp-omni",
                    "petertriho/cmp-git"
                },
                config = function()
                    vim.o.completeopt = "menuone,noselect"
                    local luasnip = require "luasnip"
                    local cmp = require "cmp"
                    cmp.setup {
                        snippet = {
                            expand = function(args)
                                require("luasnip").lsp_expand(args.body)
                            end
                        },
                        mapping = {
                            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
                            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
                            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
                            ["<C-y>"] = cmp.config.disable,
                            ["<C-e>"] = cmp.mapping(
                                {
                                    i = cmp.mapping.abort(),
                                    c = cmp.mapping.close()
                                }
                            ),
                            ["<CR>"] = cmp.mapping.confirm({select = true}),
                            ["<Tab>"] = function(fallback)
                                if cmp.visible() then
                                    cmp.select_next_item()
                                elseif luasnip.expand_or_jumpable() then
                                    luasnip.expand_or_jump()
                                else
                                    fallback()
                                end
                            end,
                            ["<S-Tab>"] = function(fallback)
                                if cmp.visible() then
                                    cmp.select_prev_item()
                                elseif luasnip.jumpable(-1) then
                                    luasnip.jump(-1)
                                else
                                    fallback()
                                end
                            end
                        },
                        sources = cmp.config.sources(
                            {
                                {name = "nvim_lsp"},
                                {name = "luasnip"},
                                {name = "buffer"},
                                {name = "nvim_lua"},
                                {
                                    name = "omni"
                                },
                                {name = "cmp_git"},
                                {name = "path"}
                            },
                            {
                                {name = "buffer"}
                            }
                        )
                    }
                    cmp.setup.cmdline(
                        "/",
                        {
                            sources = {
                                {name = "buffer"}
                            }
                        }
                    )
                    cmp.setup.cmdline(
                        ":",
                        {
                            sources = cmp.config.sources(
                                {
                                    {name = "path"}
                                },
                                {
                                    {name = "cmdline"}
                                }
                            )
                        }
                    )
                    require("cmp_git").setup()
                end
            }

            --use {'projekt0n/github-nvim-theme',config=function()
            --require('github-theme').setup()
            --end}

            use {
                "ray-x/lsp_signature.nvim",
                config = function()
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
                                border = "single" -- double, single, shadow, none
                            },
                            zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
                            padding = "" -- character to pad on left and right of signature can be ' ', or '|'  etc
                        }
                    end
                end
            }

            -- END OF LSP

            use {"tpope/vim-sleuth"}

            use {
                "kevinhwang91/rnvimr",
                config = function()
                    vim.cmd(
                        [[
			  let g:rnvimr_enable_picker = 1
			  tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
			  nnoremap <silent> <M-o> :RnvimrToggle<CR>
			  tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
			  ]]
                    )
                end
            }

            use {
                "kdheepak/lazygit.nvim",
                config = function()
                    local wk = require("which-key")
                    wk.register({g = {name = "Git", g = {"<cmd>LazyGit<CR>", "LazyGit"}}}, {prefix = "<leader>"})
                end
            }

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
            use {
                "mhinz/vim-grepper",
                config = function()
                    local wk = require("which-key")
                    wk.register({s = {g = {"<cmd>Grepper<cr>", "Grepper"}}}, {prefix = "<leader>"})
                end
            }
            use {"airblade/vim-rooter"}
            use {
                "gabrielpoca/replacer.nvim",
                config = function()
                    local wk = require("which-key")
                    wk.register(
                        {a = {r = {':lua require("replacer").run()<cr>', "Quickfix Replacer"}}},
                        {prefix = "<leader>"}
                    )
                end
            }
            --use {'tamton-aquib/staline.nvim',config=function ()
            --require('staline').setup{}
            --end}
            use {
                "sbdchd/neoformat",
                config = function()
                    local wk = require("which-key")
                    wk.register({a = {f = {"<cmd>Neoformat<cr>", "Format file"}}}, {prefix = "<leader>"})

                    vim.cmd([[let g:neoformat_enabled_python = ['black', 'docformatter'] ]])
                    vim.cmd(
                        [[
					let g:neoformat_tex_latexindent = {
					  \ 'exe': 'latexindent',
					  \ 'args': ['-l'],
					  \ 'stdin': 1
					  \ }
					  ]]
                    )
                    vim.cmd(
                        [[
                    augroup fmt
                        autocmd!
                        autocmd BufWritePre * undojoin | Neoformat
                    augroup END
                    ]]
                    )
                end
            }
            use {"tpope/vim-unimpaired"}

            use "moll/vim-bbye"
            use "aymericbeaumet/vim-symlink"
            use "AndrewRadev/bufferize.vim"
            --use {'tanvirtin/monokai.nvim',config=function ()
            --require('monokai')
            --vim.cmd('colorscheme monokai')
            --end}
            use {
                "nvim-lua/lsp-status.nvim",
                requires = "neovim/nvim-lspconfig",
                config = function()
                    local lsp_status = require("lsp-status")
                    lsp_status.register_progress()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup(
                        {
                            handlers = lsp_status.extensions.clangd.setup(),
                            init_options = {
                                clangdFileStatus = true
                            },
                            on_attach = lsp_status.on_attach,
                            capabilities = lsp_status.capabilities
                        }
                    )

                    --lspconfig.pyls_ms.setup({
                    --handlers = lsp_status.extensions.pyls_ms.setup(),
                    --settings = { python = { workspaceSymbols = { enabled = true }}},
                    --on_attach = lsp_status.on_attach,
                    --capabilities = lsp_status.capabilities
                    --})

                    lspconfig.ghcide.setup(
                        {
                            on_attach = lsp_status.on_attach,
                            capabilities = lsp_status.capabilities
                        }
                    )
                    lspconfig.rust_analyzer.setup(
                        {
                            on_attach = lsp_status.on_attach,
                            capabilities = lsp_status.capabilities
                        }
                    )
                end
            }

            use {
                "hoob3rt/lualine.nvim",
                requires = {
                    {"kyazdani42/nvim-web-devicons", opt = true},
                    {"nvim-lua/lsp-status.nvim"},
                    {"arkav/lualine-lsp-progress"}
                },
                config = function()
                    require "lualine".setup {
                        options = {
                            icons_enabled = true,
                            theme = "ayu",
                            component_separators = {"", ""},
                            section_separators = {"", ""},
                            disabled_filetypes = {}
                        },
                        sections = {
                            lualine_a = {"mode"},
                            lualine_b = {"branch"},
                            lualine_c = {"filename", "lsp_progress"},
                            --lualine_c = {'filename'},
                            --lualine_x = {'encoding' ,'fileformat', 'filetype'},
                            lualine_x = {require "lsp-status".status, "encoding", "fileformat", "filetype"},
                            lualine_y = {"progress"},
                            lualine_z = {"location"}
                        },
                        inactive_sections = {
                            lualine_a = {},
                            lualine_b = {},
                            lualine_c = {"filename"},
                            lualine_x = {"location"},
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
                    require "telescope".load_extension("frecency")
                    local wk = require("which-key")
                    wk.register(
                        {
                            t = {
                                r = {"<cmd>Telescope frecency<cr>", "Frecency"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end,
                requires = {"tami5/sqlite.lua"}
            }
            use {
                "nvim-telescope/telescope.nvim",
                requires = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope-project.nvim"},
                config = function()
                    require "telescope".load_extension("project")
                    require("telescope").setup(
                        {
                            defaults = {
                                path_display = {truncate = 3},
                                mappings = {
                                    i = {
                                        ["<C-h>"] = "which_key"
                                    }
                                },
                                file_ignore_patterns = {"node_modules", ".git/", ".vscode/", "mlruns/", "tmp/"}
                            }
                        }
                    )
                    local wk = require("which-key")
                    wk.register(
                        {
                            t = {
                                name = "Telescope",
                                f = {"<cmd>Telescope find_files<cr>", "Find files"},
                                c = {"<cmd>Telescope commands<cr>", "Commands"},
                                h = {"<cmd>Telescope command_history<cr>", "Command history"},
                                p = {":lua require'telescope'.extensions.project.project{}<CR>", "Projects"},
                                b = {"<cmd>Telescope buffers<cr>", "Buffers"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                    vim.cmd [[
							noremap <c-p> <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>
							noremap <c-a> <cmd>Telescope oldfiles<cr>
							]]
                end
            }
            use {
                "nvim-telescope/telescope-bibtex.nvim",
                config = function()
                    require "telescope".load_extension("bibtex")
                end
            }

            use {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                config = function()
                    require "nvim-treesitter.configs".setup {
                        ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                        ignore_install = {"javascript"}, -- List of parsers to ignore installing
                        highlight = {
                            enable = true, -- false will disable the whole extension
                            disable = {"rust"}, -- list of language that will be disabled
                            additional_vim_regex_highlighting = false
                        }
                    }
                end
            }
            use {"neomake/neomake"}

            --use {'kristijanhusak/orgmode.nvim', config = function()
            --require('orgmode').setup{}
            --end
            --}
            use {
                "glepnir/dashboard-nvim",
                config = function()
                    vim.cmd [[let g:dashboard_default_executive ='telescope']]
                end
            }
            --use {'gpanders/vim-oldfiles'}
            use {
                "lewis6991/gitsigns.nvim",
                requires = {
                    "nvim-lua/plenary.nvim"
                },
                config = function()
                    require("gitsigns").setup({})
                end
            }
            use {
                "skywind3000/asynctasks.vim",
                requires = {"skywind3000/asyncrun.vim", "GustavoKatel/telescope-asynctasks.nvim"},
                config = function()
                    vim.cmd([[
							let g:asyncrun_open = 6
							]])

                    local wk = require("which-key")
                    wk.register(
                        {
                            t = {
                                t = {require("telescope").extensions.asynctasks.all, "Tasks"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }

            use {
                "mfussenegger/nvim-dap",
                config = function()
                    local dap = require("dap")
                    dap.adapters.lldb = {
                        type = "executable",
                        command = "/usr/bin/lldb-vscode",
                        name = "lldb"
                    }
                    dap.adapters.gdb = {
                        type = "executable",
                        command = "/usr/bin/gdb",
                        name = "gdb"
                    }
                    dap.adapters.cppdbg = {
                        type = "executable",
                        command = "/home/heitor/Documents/Projects/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
                    }
                    dap.configurations.cpp = {
                        --{
                        --name = "Launch",
                        --type = "cppdbg",
                        --request = "launch",
                        --program = function()
                        --return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        --end,
                        --cwd = '${workspaceFolder}',
                        --stopOnEntry = false,
                        --args = {},

                        ----args = {'<','${workspaceFolder}/data/in/example.txt'},
                        ----args = {},
                        ----
                        --runInTerminal = false,
                        ----setupCommands= {
                        ----{
                        ----text= "settings set target.input-path ./data/in/input.txt"
                        ----}
                        ----},
                        --},
                        {
                            name = "Launch file",
                            type = "cppdbg",
                            request = "launch",
                            program = function()
                                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                            end,
                            cwd = "${workspaceFolder}",
                            stopOnEntry = true,
                            args = {"<", "${workspaceFolder}/data/in/example.txt"}
                        },
                        {
                            name = "Attach to gdbserver :1234",
                            type = "cppdbg",
                            request = "launch",
                            MIMode = "gdb",
                            miDebuggerServerAddress = "localhost:1234",
                            miDebuggerPath = "/usr/bin/gdb",
                            cwd = "${workspaceFolder}",
                            program = function()
                                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                            end
                        }
                    }
                    dap.configurations.c = dap.configurations.cpp
                end
            }
            use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
            --use {'neoclide/coc.nvim', branch='release',config=function ()
            --vim.cmd('source ~/.config/nvim/cocnvim.vim')
            --end}
            --
            require("dapui").setup()
            local wk = require("which-key")
            wk.register(
                {
                    d = {
                        name = "DAP",
                        c = {":lua require'dap'.continue()<CR>", "Continue"},
                        s = {":lua require'dap'.step_over()<CR>", "Step over"},
                        i = {":lua require'dap'.step_into()<CR>", "Step into"},
                        o = {":lua require'dap'.step_out()<CR>", "Step out"},
                        b = {":lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint"},
                        n = {
                            ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                            "Set condition Breakpoint"
                        },
                        m = {
                            ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
                            "log point Breakpoint"
                        },
                        r = {":lua require'dap'.repl.open()<CR>", "Relp open"},
                        l = {":lua require'dap'.run_last()<CR>", "run last"},
                        q = {':lua require("dap").terminate()<cr>', "Terminate"},
                        u = {
                            name = "DAP UI",
                            o = {':lua require("dapui").open()<cr>', "Open"},
                            c = {':lua require("dapui").close()<cr>', "Close"},
                            t = {':lua require("dapui").toggle()<cr>', "Toggle"}
                            --s={':lua require("dapui").setup()<cr>',"Setup"},
                        }
                    }
                },
                {prefix = "<leader>"}
            )
            use {
                "akinsho/toggleterm.nvim",
                config = function()
                    require("toggleterm").setup {}
                end
            }
            use {"rmagatti/auto-session"}
            use {
                "kkoomen/vim-doge",
                config = function()
                    -- Doge - docstring for any language
                    vim.cmd([[
					let g:doge_mapping='<Leader>m'
					]])
                end
            }
            use {"tpope/vim-scriptease"}
            --use {'bluz71/vim-moonfly-colors',config=function ()
            --vim.cmd [[colorscheme moonfly]]
            --require('lualine').setup({options = {theme = 'moonfly'}})
            --vim.g.moonflyCursorColor = 1
            --vim.cmd([[
            --hi Normal guibg=NONE ctermbg=NONE
            --]])
            --end}

            use {
                "xavierchow/vim-swagger-preview",
                config = function()
                    local wk = require("which-key")
                    wk.register(
                        {
                            a = {
                                s = {"<Plug>GenerateDiagram ", "Swagger preview"}
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }
            use {
                "folke/todo-comments.nvim",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                    require("todo-comments").setup {}
                end
            }
            use {
                "akinsho/bufferline.nvim",
                config = function()
                    vim.opt.termguicolors = true
                    require("bufferline").setup {}
                end
            }

            --use{'code-biscuits/nvim-biscuits',requires="nvim-treesitter/nvim-treesitter",config=function ()
            --require('nvim-biscuits').setup({
            --default_config = {
            --max_length = 12,
            --min_distance = 5,
            --prefix_string = "  "
            --},
            --language_config = {
            --python = {
            --disabled = true
            --}
            --}
            --})
            --end}
            --use{'rcarriga/nvim-notify',config=function ()
            --require("notify").setup({
            ---- Animation style (see below for details)
            --stages = "fade_in_slide_out",

            ---- Function called when a new window is opened, use for changing win settings/config
            --on_open = nil,

            ---- Render function for notifications. See notify-render()
            --render = "default",

            ---- Default timeout for notifications
            --timeout = 5000,

            ---- For stages that change opacity this is treated as the highlight behind the window
            ---- Set this to either a highlight group or an RGB hex value e.g. "#000000"
            --background_colour = "#000000",

            ---- Minimum width for notification windows
            --minimum_width = 50,

            ---- Icons for the different levels
            --icons = {
            --ERROR = "",
            --WARN = "",
            --INFO = "",
            --DEBUG = "",
            --TRACE = "✎",
            --},
            --})

            --end}

            use {"WaylonWalker/Telegraph.nvim"}
            use {"jiangmiao/auto-pairs"}
            use {
                "ThePrimeagen/harpoon",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                    require("harpoon").setup(
                        {
                            global_settings = {
                                save_on_toggle = false,
                                save_on_change = true,
                                enter_on_sendcmd = false,
                                excluded_filetypes = {"harpoon"}
                            }
                        }
                    )
                    local wk = require("which-key")
                    wk.register(
                        {
                            f = {
                                name = "Harpoon",
                                a = {':lua require("harpoon.mark").add_file()<cr>', "Add file"},
                                m = {':lua require("harpoon.ui").toggle_quick_menu()<cr>', "Quick Menu"},
                                q = {':lua require("harpoon.ui").nav_file(1)<cr>', "Go to file 1"},
                                w = {':lua require("harpoon.ui").nav_file(2)<cr>', "Go to file 2"},
                                e = {':lua require("harpoon.ui").nav_file(3)<cr>', "Go to file 3"},
                                r = {':lua require("harpoon.ui").nav_file(4)<cr>', "Go to file 4"},
                                t = {':lua require("harpoon.ui").nav_file(5)<cr>', "Go to file 5"}
                                --n={"<cmd>NvimTreeFocus<cr>","Focus"},
                            }
                        },
                        {prefix = "<leader>"}
                    )
                end
            }

            use {
                "iamcco/markdown-preview.nvim",
                config = function()
                end
            }
            use {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("nvim-ts-autotag").setup()
                end
            }

            --use{'svermeulen/vim-subversive',config=function ()
            --vim.cmd([[

            --nmap s <plug>(SubversiveSubstitute)
            --nmap ss <plug>(SubversiveSubstituteLine)
            --nmap S <plug>(SubversiveSubstituteToEndOfLine)

            --]])

            --end}

            use {
                "christianchiarulli/nvcode-color-schemes.vim",
                requires = "nvim-treesitter/nvim-treesitter",
                config = function()
                    vim.cmd(
                        [[
let g:nvcode_termcolors=256

syntax on
colorscheme snazzy " Or whatever colorscheme you make


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
]]
                    )
                end
            }

            use {
                "onsails/lspkind-nvim",
                config = function()
                    local lspkind = require("lspkind")
                    local cmp = require "cmp"
                    cmp.setup {
                        formatting = {
                            format = lspkind.cmp_format({with_text = false, maxwidth = 50})
                        }
                    }
                end
            }

            use {
                "ojroques/nvim-lspfuzzy",
                requires = {
                    {"junegunn/fzf"},
                    {"junegunn/fzf.vim"} -- to enable preview (optional)
                },
                config = function()
                    require("lspfuzzy").setup {}
                end
            }
            -- Lua
            use {
                "folke/trouble.nvim",
                requires = "kyazdani42/nvim-web-devicons",
                config = function()
                    require("trouble").setup {}
                end
            }
        end,
        config = {auto_reload_compiled = true}
    }
)
