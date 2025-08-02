return {
    'phaazon/hop.nvim',
    config = true,
    keys = {
        {'F', "<cmd>HopWord<cr>", mode = {"n", "v", "o"}},
        {'f', "<cmd>HopChar1<cr>", mode = {"n", "v", "o"}}
    }
}
