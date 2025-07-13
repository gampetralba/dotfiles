local M = {}

local function goto_definition(split_cmd)
    local params = vim.lsp.util.make_position_params(0, 'utf-8')

    vim.lsp.buf_request(0, "textDocument/definition", params,
                        function(err, result)
        if err or not result or vim.tbl_isempty(result) then return end

        vim.cmd(split_cmd)
        vim.lsp.util.show_document(result[1], "utf-8", {focus = true})
    end)
end

M.definition_new_tab = function() goto_definition("tabnew") end

M.definition_vsplit = function() goto_definition("vsplit") end

return M
