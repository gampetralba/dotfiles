return {
    'kyazdani42/nvim-tree.lua',
    opts = {
        view = {number = true, relativenumber = true},
        renderer = {
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = true
                }
            }
        },
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.set("n", "<leader>om", function()
                local node = api.tree.get_node_under_cursor()
                if not (node and node.absolute_path and
                    node.absolute_path:match("%.md$")) then return end
                local out = "/tmp/pandoc-" ..
                                vim.fn.fnamemodify(node.absolute_path, ":t:r") ..
                                ".html"
                vim.system({
                    "pandoc", "-s", "-c",
                    "https://cdn.simplecss.org/simple.min.css",
                    node.absolute_path, "-o", out
                }, {}, function(obj)
                    if obj.code == 0 then
                        vim.schedule(function()
                            vim.fn.jobstart({"open", out}, {detach = true})
                        end)
                    else
                        vim.schedule(function()
                            vim.notify("pandoc failed: " .. obj.stderr,
                                       vim.log.levels.ERROR)
                        end)
                    end
                end)
            end, {buffer = bufnr, desc = "render markdown to browser"})
        end
    },
    keys = {
        {"<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "nvim-tree toggle"},
        {
            "<leader><C-n>",
            "<cmd>NvimTreeFindFile<CR>",
            desc = "nvim-tree find file"
        }, {"<leader>fn", "<cmd>NvimTreeFocus<CR>", desc = "nvim-tree focus"}
    }
}
