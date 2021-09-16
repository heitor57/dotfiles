vim.cmd([[
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
set cursorline
set tabstop=2
set number
set hlsearch
set incsearch
set inccommand=nosplit
set spelllang=en
set wrap
cnoremap <C-v> <C-r>+
set timeoutlen=500
]])

-- function sleep(n)
--   os.execute("sleep " .. tonumber(n))
-- end

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "monokai"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.visual_mode["//"] = [=========[y/\V<C-R>=escape(@",'/\')<CR><CR>]=========]
-- lvim.transparent_window = true
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings['a'] =  { name="General" ,
  s = {"<cmd>set spell!<cr>", "spelling cycle"},
  m = {'<cmd>Neomake!<cr>', "Neomake current dir"}
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
}
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files hidden=true<CR>", "Find File"}
-- lvim.builtin.which_key.mappings["s"]["f"] = { "<cmd>Telescope find_files hidden=true<CR>", "Find File"}
lvim.builtin.which_key.mappings["s"]["g"] = { "<cmd>Telescope git_files<CR>", "Find Git File"}
lvim.builtin.which_key.opts.nowait=false

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
-- lvim.builtin.telescope.defaults

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = false
lvim.builtin.treesitter.active = false
lvim.builtin.treesitter.on_config_done = function ()
  vim.cmd([[
  set foldminlines=20
  set foldlevel=4
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  ]])
end
lvim.builtin.telescope.defaults.file_ignore_patterns = {'.git/'}
lvim.builtin.telescope.defaults.hidden = true
-- lvim.builtin.telescope.on_config_done = function (telescope)
--   -- telescope.setup({extensions = {
--   -- 					project = {
--   -- 						hidden_files = true, -- default: false
--   -- 					},
--   -- 				}})
--   telescope.setup({defaults = {hidden=true}})
-- end

-- lvim.builtin.compe.

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   client = client
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--   -- local opts = { noremap=true, silent=true }
--   buf_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- lvim.leader = 1
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- -- set an additional linter

-- lvim.lang.python.linters = { { exe = "flake8" } }
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"}, {
--         "ray-x/lsp_signature.nvim",
--         config = function() require"lsp_signature".on_attach() end,
--         event = "InsertEnter"
--     }
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
lvim.plugins = {
  {"lunarvim/colorschemes"},
  {"folke/tokyonight.nvim"}, 
  {"folke/trouble.nvim"},
  {"kevinhwang91/rnvimr",
    config = function ()
      vim.cmd([[
      let g:rnvimr_enable_picker = 1]])
    end
  },
  {
    "brymer-meneses/grammar-guard.nvim",
    requires="neovim/nvim-lspconfig",
    config = function()
    end,
  },
  {
    "lervag/vimtex",config=function ()
      lvim.builtin.which_key.mappings['i'] = {"<plug>(vimtex-compile)", "VimTex Compile" }
    end
  },
  {"airblade/vim-gitgutter"},
  {"neomake/neomake"},
  {'tpope/vim-fugitive',config=function ()
    lvim.builtin.which_key.mappings['g']['f'] = {"<cmd>G<cr>","Vim-Fugitive"}
    lvim.builtin.which_key.mappings['g']['P'] = {"<cmd>G push<cr>","Vim-Fugitive Push"}
  end
  },

  {'ray-x/lsp_signature.nvim',config=function ()
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
  end},

  {"ellisonleao/glow.nvim"},
  {"jalvesaq/zotcite",config=function ()
  end},
  {'iamcco/markdown-preview.nvim',config=function ()
  end},
  {'sbdchd/neoformat'},
}
