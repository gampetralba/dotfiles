return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    }, {
        "nvim-telescope/telescope.nvim",

        config = function()
            local actions = require("telescope.actions")
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous
                        }
                    },
                    layout_config = {
                        horizontal = {
                            height = 0.9,
                            width = 0.9,
                            preview_cutoff = 120,
                            prompt_position = "bottom"
                        }
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case"
                    }
                }
            })

            telescope.load_extension("fzf")
        end,
        keys = {
            {
                "<C-p>",
                "<cmd>lua require('telescope.builtin').find_files()<cr>",
                desc = "Find Files"
            },
            {
                "<leader><C-p>",
                ":call git#ListFiles()<CR>",
                desc = "Git List Files"
            }, {
                "<leader>fg",
                "<cmd>lua require('telescope.builtin').live_grep()<cr>",
                desc = "Live Grep"
            },
            {
                "gb",
                "<cmd>lua require('telescope.builtin').buffers()<cr>",
                desc = "Buffers"
            }, {
                "<leader>fh",
                "<cmd>lua require('telescope.builtin').help_tags()<cr>",
                desc = "Help Tags"
            }
        }
    }
}
