local actions = require('telescope.actions')
local telescope = require('telescope');

telescope.setup {
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
}

telescope.load_extension('fzf')
