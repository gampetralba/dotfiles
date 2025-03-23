vim.api.nvim_set_keymap("n", "<leader>dq",
                        "<cmd>lua vim.diagnostic.setqflist()<CR>",
                        {noremap = true})
