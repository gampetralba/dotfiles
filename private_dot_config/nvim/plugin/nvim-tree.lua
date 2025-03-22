require'nvim-tree'.setup {
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
}
