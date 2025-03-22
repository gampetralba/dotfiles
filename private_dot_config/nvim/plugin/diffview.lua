require("diffview").setup()

vim.api.nvim_set_keymap('n', '<leader>dv', [[<CMD> DiffviewOpen<CR>]],
                        {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>dh', [[<CMD> DiffviewFileHistory<CR>]],
                        {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>df', [[<CMD> DiffviewFileHistory %<CR>]],
                        {noremap = true})
