return {
    'kyazdani42/nvim-tree.lua',
    opts = {
        view = {number = true, relativenumber = true},
        renderer = {
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = true
                }
            }
        }
    },
    keys = {
        {"<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "nvim-tree toggle"},
        {
            "<leader><C-n>",
            "<cmd>NvimTreeFindFile<CR>",
            desc = "nvim-tree find file"
        }, {"<leader>fn", "<cmd>NvimTreeFocus<CR>", desc = "nvim-tree focus"}
    }
}
