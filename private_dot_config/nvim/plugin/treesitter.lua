require('nvim-treesitter.configs').setup {
    ensure_installed = "all",

    highlight = {enable = true, disable = {'yaml', 'vim', 'lua'}},

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
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?'
        }
    }
}

-- LuaFormatter off
vim.api.nvim_set_hl(0, "@tag.tsx", {fg = vim.g.terminal_color_12})
vim.api.nvim_set_hl(0, "@tag.attribute.tsx", {fg = vim.g.terminal_color_14})
vim.api.nvim_set_hl(0, "@constructor.tsx", {fg = vim.g.terminal_color_12})
vim.api.nvim_set_hl(0, "@constructor.ts", {fg = vim.g.terminal_color_12})

vim.api.nvim_set_hl(0, "@tag.javascript", {fg = vim.g.terminal_color_12})
vim.api.nvim_set_hl(0, "@tag.attribute.javascript", {fg = vim.g.terminal_color_14})
vim.api.nvim_set_hl(0, "@constructor.javascript", {fg = vim.g.terminal_color_12})
-- vim.api.nvim_set_hl(0, "@tag", {fg = vim.g.terminal_color_12})
-- vim.api.nvim_set_hl(0, "@tag.attribute", {fg = vim.g.terminal_color_14})
-- vim.api.nvim_set_hl(0, "@constructor", {fg = vim.g.terminal_color_12})
-- vim.api.nvim_set_hl(0, "@variable.js", {fg = vim.g.terminal_color_12})
-- LuaFormatter on

vim.api.nvim_exec([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]], true)
