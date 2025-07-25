return {
    {
        "mhartington/formatter.nvim",
        config = function()
            -- Global variable to track format-on-save state
            vim.g.format_on_save = true

            require("formatter").setup({
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {
                        function()
                            return {
                                exe = "lua-format",
                                args = {"-i"},
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
                    json = {require("formatter.filetypes.json").prettier},
                    html = {require("formatter.filetypes.html").prettier},
                    css = {require("formatter.filetypes.css").prettier},
                    scss = {require("formatter.filetypes.css").prettier},
                    ruby = {require("formatter.filetypes.ruby").rubocop},
                    rust = {require("formatter.filetypes.rust").rustfmt},
                    cpp = {require("formatter.filetypes.cpp").clangformat},
                    python = {require("formatter.filetypes.python").black},
                    go = {require("formatter.filetypes.go").gofmt},
                    yaml = {require("formatter.filetypes.yaml").prettier},
                    markdown = {require("formatter.filetypes.markdown").prettier},
                    sh = {require("formatter.filetypes.sh").shfmt},
                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace
                    }
                }
            })

            -- Format on save autocommand with toggle support
            local format_group = vim.api.nvim_create_augroup("FormatAutogroup", {clear = true})
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = format_group,
                callback = function()
                    if vim.g.format_on_save then
                        local success, error = pcall(function()
                            vim.api.nvim_command("FormatWrite")
                        end)
                        if not success then
                            vim.notify("Formatting failed: " .. error, vim.log.levels.WARN)
                        end
                    end
                end
            })

            -- Create FormatToggle command
            vim.api.nvim_create_user_command("FormatToggle", function()
                vim.g.format_on_save = not vim.g.format_on_save
                local state = vim.g.format_on_save and "enabled" or "disabled"
                vim.notify("Format on save " .. state, vim.log.levels.INFO)
            end, {
                desc = "Toggle format on save"
            })

            -- Create Format command if it doesn't exist
            vim.api.nvim_create_user_command("Format", function()
                local success, error = pcall(function()
                    vim.api.nvim_command("FormatWrite")
                end)
                if not success then
                    vim.notify("Formatting failed: " .. error, vim.log.levels.ERROR)
                else
                    vim.notify("Buffer formatted", vim.log.levels.INFO)
                end
            end, {
                desc = "Format current buffer"
            })
        end
    }
}