local M = {}

M.definition_new_tab = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local method = "textDocument/definition"
    local params = vim.lsp.util.make_position_params()
    vim.cmd [[tabnew]]
    vim.lsp.buf_request(bufnr, method, params)
end

M.definition_vsplit = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local method = "textDocument/definition"
    local params = vim.lsp.util.make_position_params()
    vim.cmd [[vsplit]]
    vim.lsp.buf_request(bufnr, method, params)
end

return M
