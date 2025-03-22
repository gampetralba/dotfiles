local luatab = require('luatab')
local luatab_helpers = luatab.helpers

local cell = function(index)
    local isSelected = vim.fn.tabpagenr() == index
    local buflist = vim.fn.tabpagebuflist(index)
    local winnr = vim.fn.tabpagewinnr(index)
    local bufnr = buflist[winnr]
    local hl = (isSelected and '%#TabLineSel#' or '%#TabLine#')

    return hl .. '%' .. index .. 'T' .. ' ' .. index .. '. ' ..
               luatab_helpers.title(bufnr) .. ' ' ..
               luatab_helpers.modified(bufnr) ..
               luatab_helpers.devicon(bufnr, isSelected) ..
               luatab_helpers.windowCount(index) .. '%T' ..
               luatab_helpers.separator(index)
end

luatab.setup({cell = cell})
