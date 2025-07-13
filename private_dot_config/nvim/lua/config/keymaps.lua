-- Map source neovim config
vim.api.nvim_set_keymap("n", "<Leader>sv", ":source $MYVIMRC<CR>",
                        {noremap = true})
-- Clipboard
vim.keymap.set("v", "<C-c>", '"+y', {noremap = true, silent = true})

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
