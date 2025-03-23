return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
            local luasnip = require("luasnip")

            luasnip.config.set_config({
                enable_autosnippets = true,
                store_selection_keys = "<Tab>"
            })

            require("luasnip.loaders.from_lua").load({
                paths = "~/.config/nvim/snippets/"
            })

            vim.keymap.set("i", "<Tab>", function()
                return luasnip.expand_or_jumpable() and
                           "<Plug>luasnip-expand-or-jump" or "<Tab>"
            end, {expr = true, silent = true})

            vim.keymap.set("i", "<S-Tab>",
                           "<cmd>lua require'luasnip'.jump(-1)<CR>",
                           {silent = true})
            vim.keymap.set("s", "<Tab>",
                           "<cmd>lua require'luasnip'.jump(1)<CR>",
                           {silent = true})
            vim.keymap.set("s", "<S-Tab>",
                           "<cmd>lua require'luasnip'.jump(-1)<CR>",
                           {silent = true})

            vim.keymap.set("i", "<C-E>", function()
                return
                    luasnip.choice_active() and "<Plug>luasnip-next-choice" or
                        "<C-E>"
            end, {expr = true, silent = true})

            vim.keymap.set("s", "<C-E>", function()
                return
                    luasnip.choice_active() and "<Plug>luasnip-next-choice" or
                        "<C-E>"
            end, {expr = true, silent = true})
        end
    }
}
