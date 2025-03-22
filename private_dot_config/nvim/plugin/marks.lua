require('marks').setup({
    signs = false,
    sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20}
})

vim.keymap.set("n", "<leader>mb", [[<CMD> MarksListBuf<CR>]])
vim.keymap.set("n", "<leader>mg", [[<CMD> MarksListGlobal<CR>]])
vim.keymap.set("n", "<leader>ma", [[<CMD> MarksListAll<CR>]])
vim.keymap.set("n", "<leader>mt", [[<CMD> MarksToggleSigns<CR>]])
