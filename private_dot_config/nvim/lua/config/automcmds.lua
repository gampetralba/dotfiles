local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {clear = true})

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
    pattern = "*",
    command = "set relativenumber cursorline",
    group = numbertoggle
})

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
    pattern = "*",
    command = "set norelativenumber nocursorline",
    group = numbertoggle
})

-- Store last accessed tab
local tableave = vim.api.nvim_create_augroup("tableave", {clear = true})

vim.api.nvim_create_autocmd("TabLeave", {
    pattern = "*",
    callback = function() vim.g.lasttab = vim.fn.tabpagenr() end,
    group = tableave
})

-- Disable relative numbers in floating windows and special buffers
local floatwin = vim.api.nvim_create_augroup("floatwin", {clear = true})

vim.api.nvim_create_autocmd({"WinEnter", "BufWinEnter", "FileType", "BufEnter"}, {
    pattern = "*",
    callback = function(args)
        local win = vim.api.nvim_get_current_win()
        local buf = args.buf or vim.api.nvim_win_get_buf(win)
        local config = vim.api.nvim_win_get_config(win)
        local buftype = vim.bo[buf].buftype
        local filetype = vim.bo[buf].filetype
        local bufname = vim.api.nvim_buf_get_name(buf)
        
        -- Only apply to actual floating windows (not regular windows)
        if config.relative ~= "" then
            vim.wo[win].relativenumber = false
            vim.wo[win].number = false  -- Disable all line numbers
            vim.wo[win].cursorline = false
            vim.wo[win].signcolumn = "no"
        end
    end,
    group = floatwin
})

-- Also handle LSP hover windows specifically
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        -- Override LSP hover handler to disable line numbers
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
            local bufnr, winnr = orig_util_open_floating_preview(contents, syntax, opts)
            if winnr then
                vim.wo[winnr].number = false
                vim.wo[winnr].relativenumber = false
                vim.wo[winnr].cursorline = false
                vim.wo[winnr].signcolumn = "no"
            end
            return bufnr, winnr
        end
    end,
})
