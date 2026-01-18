return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {theme = 'nord'},
        sections = {
            lualine_x = {
                {
                    function()
                        if vim.g.global_readonly then
                            return "🔒 LOCKED"
                        elseif not vim.bo.modifiable then
                            return "🔒"
                        end
                        return ""
                    end,
                    color = {fg = "#bf616a"},
                },
                'encoding',
                'fileformat',
                'filetype',
            },
        },
        extensions = {'fugitive', 'fzf', 'nvim-tree', 'quickfix'}
    }
}
