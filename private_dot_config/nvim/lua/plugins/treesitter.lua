return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        keys = {
            { "gnn", desc = "Init incremental selection" },
            { "grn", desc = "Increment node selection", mode = "x" },
            { "grm", desc = "Decrement node selection", mode = "x" },
            { "grc", desc = "Increment scope selection", mode = "x" },
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Install only commonly used parsers for better performance
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "dockerfile",
                    "go",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "regex",
                    "ruby",
                    "rust",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },

                -- Auto install missing parsers when opening files
                auto_install = true,
                
                -- Don't install parsers synchronously (faster startup)
                sync_install = false,

                highlight = {
                    enable = true,
                    -- Remove disable list - let treesitter handle all languages
                    -- Use additional_vim_regex_highlighting for any problematic languages
                    additional_vim_regex_highlighting = false,
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm"
                    }
                },

                indent = {
                    enable = true,
                    -- Disable for problematic languages
                    disable = { "python", "yaml" }
                },

                -- Enhanced text objects for better code navigation
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]k"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]K"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[k"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[K"] = "@class.outer",
                        },
                    },
                },

                -- Remove playground config (deprecated, use :InspectTree instead)
            })

            -- Optimized custom highlights (only set what you actually need)
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

            -- Set highlights after colorscheme loads
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = set_custom_highlights,
                desc = "Set custom treesitter highlights"
            })
            
            -- Set highlights now if colors are available
            set_custom_highlights()

            -- Enhanced folding with treesitter
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            vim.opt.foldenable = false -- Start with folds open
            vim.opt.foldlevel = 99
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
}