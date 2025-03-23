return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",

                highlight = {enable = true, disable = {"yaml", "vim", "lua"}},

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm"
                    }
                },

                indent = {enable = true},

                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25,
                    persist_queries = false,
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?"
                    }
                }
            })

            -- Custom highlights
            local set_hl = vim.api.nvim_set_hl
            local colors = vim.g
            set_hl(0, "@tag.tsx", {fg = colors.terminal_color_12})
            set_hl(0, "@tag.attribute.tsx", {fg = colors.terminal_color_14})
            set_hl(0, "@constructor.tsx", {fg = colors.terminal_color_12})
            set_hl(0, "@constructor.ts", {fg = colors.terminal_color_12})
            set_hl(0, "@tag.javascript", {fg = colors.terminal_color_12})
            set_hl(0, "@tag.attribute.javascript",
                   {fg = colors.terminal_color_14})
            set_hl(0, "@constructor.javascript", {fg = colors.terminal_color_12})

            -- Treesitter-based folding
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        end
    }
}
