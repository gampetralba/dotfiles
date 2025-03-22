-- LuaFormatter off
require("formatter").setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        lua = {
            function ()
               return {
                    exe = "lua-format",
                    args = { "-i" },
                    stdin = true
                }

            end
        },

        javascript = {
            require("formatter.filetypes.javascript").prettier
        },

        javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettier
        },

        typescript = {
            require("formatter.filetypes.typescript").prettier
        },

        typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier
        },

        json = {
            require("formatter.filetypes.json").prettier
        },

        html = {
            require("formatter.filetypes.html").prettier
        },

        css = {
            require("formatter.filetypes.css").prettier
        },

        scss = {
            require("formatter.filetypes.css").prettier
        },

        ruby = {
            require("formatter.filetypes.ruby").rubocop
        },

        rust = {
            require("formatter.filetypes.rust").rustfmt
        },

        cpp = {
            require("formatter.filetypes.cpp").uncrustify
        },

        python = {
            require("formatter.filetypes.python").yapf
        },

        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}
-- LuaFormatter on

local group = "FormatAutogroup"

vim.api.nvim_create_augroup(group, {clear = true})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = group,
    callback = function() vim.api.nvim_command('FormatWrite') end
})
