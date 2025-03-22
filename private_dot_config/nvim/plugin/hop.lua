require'hop'.setup()

vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_words()<cr>", {})

vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {})
