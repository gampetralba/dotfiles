return {
    "nordtheme/vim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- Set Nord theme options
        vim.g.nord_cursor_line_number_background = 1

        -- load the colorscheme here
        vim.cmd([[colorscheme nord]])
    end
}
