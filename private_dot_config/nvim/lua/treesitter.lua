local M = {}

local ts_utils = require('nvim-treesitter.ts_utils')

local is_jsx_element = function(type)
    return type == 'jsx_element' or type == 'jsx_fragment' or type ==
               'jsx_self_closing_element'
end

M.go_to_parent_jsx_element = function()
    local jumps = 0
    local node = ts_utils.get_node_at_cursor()
    local root = ts_utils.get_root_for_node(node)
    local parent = node
    if (is_jsx_element(node:type())) then jumps = jumps + 1 end

    while (parent ~= root and jumps < 2) do
        parent = parent:parent()
        if is_jsx_element(parent:type()) then jumps = jumps + 1 end
    end

    if (parent == root) then print("Currently at root jsx element.") end
    if parent ~= root then ts_utils.goto_node(parent) end
end

M.go_to_parent_key = function()
    local node = ts_utils.get_node_at_cursor()
    local root = ts_utils.get_root_for_node(node)
    local jumps = 0

    while (node ~= root and jumps < 2) do
        node = node:parent()
        if (node:type() == "pair") then jumps = jumps + 1 end
    end

    if (node == root) then
        ts_utils.goto_node(root)
    else
        local key = node:child({0}):child({0})
        ts_utils.goto_node(key)
    end
end

return M
