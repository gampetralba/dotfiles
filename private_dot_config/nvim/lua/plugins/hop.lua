return {
    'phaazon/hop.nvim',
    config = true,
    keys = {
        {'F', "<cmd>lua require'hop'.hint_words()<cr>"},
        {'f', "<cmd>lua require'hop'.hint_char1()<cr>"}
    }
}
