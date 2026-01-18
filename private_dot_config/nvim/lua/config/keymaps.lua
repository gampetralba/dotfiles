-- Map source neovim config
vim.api.nvim_set_keymap("n", "<Leader>sv", ":source $MYVIMRC<CR>",
                        {noremap = true})
-- Clipboard
vim.keymap.set("v", "<C-c>", '"+y', {noremap = true, silent = true})

-- Copy relative file path to clipboard
vim.keymap.set("n", "<leader>cp", function()
    local relative_path = vim.fn.expand("%:.")
    if relative_path ~= "" then
        vim.fn.setreg("+", relative_path)
        vim.notify("Copied: " .. relative_path, vim.log.levels.INFO)
    else
        vim.notify("No file in current buffer", vim.log.levels.WARN)
    end
end, {noremap = true, silent = true, desc = "Copy relative file path"})

-- Yank code with file path
vim.keymap.set("v", "<leader>y", function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local relative_path = vim.fn.expand("%:.")

    vim.cmd('normal! "xy')
    local code = vim.fn.getreg("x")

    local content = string.format("%s:%d-%d\n```\n%s```", relative_path,
                                  start_line, end_line, code)

    vim.fn.setreg("+", content)
    vim.notify("Yanked code with path", vim.log.levels.INFO)
end, {noremap = true, silent = true, desc = "Yank code with file path"})

-- Escape key
vim.keymap.set("i", "jj", "<Esc>", {noremap = true, silent = true})

-- Split
vim.keymap.set("n", "<leader>ws", "<C-w>s", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>wv", "<C-w>v", {noremap = true, silent = true})

-- Tabs
vim.keymap.set("n", "tn", function()
    vim.cmd("tabnew")
    vim.cmd("cd " .. vim.fn.getcwd())
end, {noremap = true})
vim.keymap.set("n", "tt", function() vim.cmd("tabnew %") end, {noremap = true})
vim.keymap.set("n", "tk", ":tabnext<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "tj", ":tabprev<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "tp", ":tabclose<CR>", {noremap = true, silent = true})

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, i .. "gt",
                   {noremap = true, silent = true})
end

vim.keymap
    .set("n", "<leader>0", ":tablast<CR>", {noremap = true, silent = true})

vim.keymap.set("n", "tl", function()
    if vim.g.lasttab then vim.cmd("tabn " .. vim.g.lasttab) end
end, {noremap = true, silent = true})

-- Paste without auto indentation
vim.keymap.set("n", "<leader>p", function()
    vim.opt.paste = true
    vim.cmd('"*p') -- Paste from system clipboard
    vim.opt.paste = false
end, {noremap = true, silent = true})

-- Buffer
vim.keymap.set("n", "gp", ":bp<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "gn", ":bn<CR>", {noremap = true, silent = true})

-- Location list
vim.keymap.set("n", "<leader>lo", ":lopen<CR>", {noremap = true, silent = true})

vim.keymap
    .set("n", "<leader>lc", ":lclose<CR>", {noremap = true, silent = true})

-- Quickfix list
vim.keymap.set("n", "<leader>qo", ":copen<CR>", {noremap = true, silent = true})

vim.keymap
    .set("n", "<leader>qc", ":cclose<CR>", {noremap = true, silent = true})

-- Help
vim.keymap.set("n", "<leader>hv", ":vert help ", {noremap = true})

-- Diagnostic
vim.keymap.set("n", "<leader>dq", "<cmd>lua vim.diagnostic.setqflist()<CR>",
               {noremap = true})

-- Read-only toggle (buffer)
vim.keymap.set("n", "<leader>ro", function()
    vim.bo.modifiable = not vim.bo.modifiable
    vim.notify(vim.bo.modifiable and "Editable" or "Read-only")
end, {noremap = true, silent = true, desc = "Toggle buffer read-only"})

-- Read-only toggle (global)
vim.keymap.set("n", "<leader>rO", function()
    local lock = vim.g.global_readonly or false
    vim.g.global_readonly = not lock
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            vim.bo[buf].modifiable = lock
        end
    end
    vim.notify(lock and "All buffers editable" or "All buffers read-only")
end, {noremap = true, silent = true, desc = "Toggle global read-only"})
