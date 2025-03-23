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
