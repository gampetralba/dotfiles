return {
    "tpope/vim-fugitive",
    keys = {
        {
            "<leader>gdv",
            ":Gvdiffsplit!<CR>",
            mode = "n",
            desc = "Git diff split"
        }, {
            "<leader>gdh",
            ":diffget //2<CR>",
            mode = {"n", "v"},
            desc = "Git diff get left"
        }, {
            "<leader>gdl",
            ":diffget //3<CR>",
            mode = {"n", "v"},
            desc = "Git diff get right"
        }, {"<leader>gdg", ":diffget<CR>", mode = "n", desc = "Git diff get"},
        {"<leader>gdp", ":diffput<CR>", mode = "n", desc = "Git diff put"},
        {"<leader>gv", ":Gvdiff<CR>", mode = "n", desc = "Git vertical diff"},
        {"<leader>gs", ":tab G<CR>", mode = "n", desc = "Git status"},
        {"<leader>gc", ":Git commit<CR>", mode = "n", desc = "Git commit"},
        {
            "<leader>ge",
            ":tabnew<CR>:Gedit<Space>",
            mode = "n",
            desc = "Git edit"
        }, {"<leader>gr", ":Gread<CR>", mode = "n", desc = "Git read"},
        {"<leader>gw", ":Gwrite<CR><CR>", mode = "n", desc = "Git write"},
        {"<leader>gl", ":tabnew<CR>:Gclog<CR>", mode = "n", desc = "Git log"},
        {
            "<leader>ogl",
            ":tabnew<Space>%<CR>:0Gclog<CR>",
            mode = "n",
            desc = "Git log (open in new tab)"
        }, {"<leader>gb", ":Git blame<CR>", mode = "n", desc = "Git blame"},
        {
            "<leader>go",
            ":Git checkout<Space>",
            mode = "n",
            desc = "Git checkout"
        },
        {"<leader>gps", ":terminal git push<CR>", mode = "n", desc = "Git push"},
        {"<leader>gpl", ":terminal git pull<CR>", mode = "n", desc = "Git pull"}
    },
    config = function()
        vim.api.nvim_create_augroup("Fugitive", {clear = true})

        vim.api.nvim_create_autocmd("User", {
            group = "Fugitive",
            pattern = "fugitive",
            callback = function()
                if vim.fn.exists(":Gedit") == 2 then
                    vim.api.nvim_buf_set_keymap(0, "n", "..", ":edit %:h<CR>",
                                                {noremap = true, silent = true})
                end
            end
        })

        vim.api.nvim_create_autocmd("BufReadPost", {
            group = "Fugitive",
            pattern = "fugitive://*",
            command = "set bufhidden=delete"
        })
    end
}
