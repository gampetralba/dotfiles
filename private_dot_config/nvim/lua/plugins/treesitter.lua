return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- Install parsers (runs async)
            require("nvim-treesitter").install({
                "bash", "c", "cpp", "css", "dockerfile", "go", "html",
                "javascript", "json", "lua", "markdown", "markdown_inline",
                "python", "regex", "ruby", "rust", "tsx", "typescript",
                "vim", "vimdoc", "yaml",
            })

            -- Enable treesitter highlighting, indentation, and folding
            local indent_disable = { python = true, yaml = true }

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local ok = pcall(vim.treesitter.start)
                    if ok then
                        vim.wo[0][0].foldmethod = "expr"
                        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                        if not indent_disable[vim.bo.filetype] then
                            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    end
                end,
                desc = "Enable treesitter highlight, folds, and indent",
            })

            vim.opt.foldenable = false
            vim.opt.foldlevel = 99

            -- Incremental selection via treesitter nodes
            local function get_node_range(node)
                local sr, sc, er, ec = node:range()
                return sr, sc, er, ec
            end

            local function select_node(node)
                if not node then return end
                local sr, sc, er, ec = get_node_range(node)
                vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
                vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
                vim.cmd("normal! gv")
            end

            vim.keymap.set("n", "gnn", function()
                local node = vim.treesitter.get_node()
                if node then
                    select_node(node)
                    vim.b._ts_selected_node = true
                end
            end, { desc = "Init incremental selection" })

            vim.keymap.set("x", "grn", function()
                local node = vim.treesitter.get_node()
                if node then
                    local parent = node:parent()
                    if parent then
                        select_node(parent)
                    end
                end
            end, { desc = "Increment node selection" })

            vim.keymap.set("x", "grm", function()
                local node = vim.treesitter.get_node()
                if node then
                    local child = node:child(0)
                    if child then
                        select_node(child)
                    end
                end
            end, { desc = "Decrement node selection" })

            vim.keymap.set("x", "grc", function()
                local node = vim.treesitter.get_node()
                if node then
                    local parent = node:parent()
                    while parent and parent:parent() do
                        parent = parent:parent()
                    end
                    if parent then
                        select_node(parent)
                    end
                end
            end, { desc = "Increment scope selection" })

            -- Custom highlights
            local function set_custom_highlights()
                local colors = vim.g
                if colors.terminal_color_12 and colors.terminal_color_14 then
                    local highlights = {
                        ["@tag.tsx"] = { fg = colors.terminal_color_12 },
                        ["@tag.attribute.tsx"] = { fg = colors.terminal_color_14 },
                        ["@constructor.tsx"] = { fg = colors.terminal_color_12 },
                        ["@constructor.ts"] = { fg = colors.terminal_color_12 },
                        ["@tag.javascript"] = { fg = colors.terminal_color_12 },
                        ["@tag.attribute.javascript"] = { fg = colors.terminal_color_14 },
                        ["@constructor.javascript"] = { fg = colors.terminal_color_12 },
                    }
                    for group, opts in pairs(highlights) do
                        vim.api.nvim_set_hl(0, group, opts)
                    end
                end
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = set_custom_highlights,
                desc = "Set custom treesitter highlights",
            })
            set_custom_highlights()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            -- Select keymaps
            local select_obj = function(query)
                return function()
                    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
                end
            end

            vim.keymap.set({ "x", "o" }, "af", select_obj("@function.outer"), { desc = "outer function" })
            vim.keymap.set({ "x", "o" }, "if", select_obj("@function.inner"), { desc = "inner function" })
            vim.keymap.set({ "x", "o" }, "ac", select_obj("@class.outer"), { desc = "outer class" })
            vim.keymap.set({ "x", "o" }, "ic", select_obj("@class.inner"), { desc = "inner class" })
            vim.keymap.set({ "x", "o" }, "aa", select_obj("@parameter.outer"), { desc = "outer parameter" })
            vim.keymap.set({ "x", "o" }, "ia", select_obj("@parameter.inner"), { desc = "inner parameter" })

            -- Move keymaps
            local move = require("nvim-treesitter-textobjects.move")

            vim.keymap.set({ "n", "x", "o" }, "]f", function()
                move.goto_next_start("@function.outer", "textobjects")
            end, { desc = "Next function start" })

            vim.keymap.set({ "n", "x", "o" }, "]F", function()
                move.goto_next_end("@function.outer", "textobjects")
            end, { desc = "Next function end" })

            vim.keymap.set({ "n", "x", "o" }, "[f", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end, { desc = "Prev function start" })

            vim.keymap.set({ "n", "x", "o" }, "[F", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end, { desc = "Prev function end" })

            vim.keymap.set({ "n", "x", "o" }, "]k", function()
                move.goto_next_start("@class.outer", "textobjects")
            end, { desc = "Next class start" })

            vim.keymap.set({ "n", "x", "o" }, "]K", function()
                move.goto_next_end("@class.outer", "textobjects")
            end, { desc = "Next class end" })

            vim.keymap.set({ "n", "x", "o" }, "[k", function()
                move.goto_previous_start("@class.outer", "textobjects")
            end, { desc = "Prev class start" })

            vim.keymap.set({ "n", "x", "o" }, "[K", function()
                move.goto_previous_end("@class.outer", "textobjects")
            end, { desc = "Prev class end" })
        end,
    },
}
