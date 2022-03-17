function TableConcat(t1, t2)
    for i = 1, #t2 do t1[#t1 + 1] = t2[i] end
    return t1
end
return require("packer").startup({
    function()
        use { -- packages manager
            "wbthomason/packer.nvim",
            config = function()
                local wk = require("which-key")
                wk.setup({
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
                    hidden = {
                        "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua",
                        "^:", "^ "
                    } -- hide mapping boilerplate
                })
                wk.register({
                    p = {
                        name = "Packer",
                        s = {"<cmd>PackerSync<cr>", "Sync"},
                        i = {"<cmd>PackerInstall<cr>", "Install"},
                        c = {"<cmd>PackerCompile<cr>", "Compile"},
                        l = {"<cmd>PackerClean<cr>", "Clean"}
                    }
                }, {prefix = "<leader>"})
            end
        }
        use { -- keys manager
            "folke/which-key.nvim",
            config = function()
                local wk = require("which-key")
                wk.setup {}
                wk.register({
                    a = {
                        name = "General",
                        c = {"<cmd>e $MYVIMRC<cr>", "Edit Config"}
										}
                }, {prefix = "<leader>"})
            end
        }
        use { -- commenter
            "preservim/nerdcommenter",
            setup = function()
                vim.cmd([[
		let g:NERDCreateDefaultMappings=0
		]])
            end,
            config = function()
                vim.cmd([[
		filetype plugin on
		vmap <leader>/ <plug>NERDCommenterToggle
		nmap <leader>/ <plug>NERDCommenterToggle
		]])
            end
        }

        use {"nvim-lua/plenary.nvim"} -- utils
    end,
    config = {auto_reload_compiled = true, max_jobs=13}
})
