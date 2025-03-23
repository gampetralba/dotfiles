return {
    'chentoast/marks.nvim',
    opts = {
        signs = false,
        sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20}
    },
    keys = {
        {'<leader>mb', [[<CMD> MarksListBuf<CR>]]},
        {'<leader>mg', [[<CMD> MarksListGlobal<CR>]]},
        {'<leader>ma', [[<CMD> MarksListAll<CR>]]},
        {'<leader>mt', [[<CMD> MarksToggleSigns<CR>]]}
    }
}
