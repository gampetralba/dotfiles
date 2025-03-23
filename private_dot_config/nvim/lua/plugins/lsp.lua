return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {"hrsh7th/cmp-nvim-lsp"},
        config = function()
            local nvim_lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.o.completeopt = "menu,menuone,noselect"

            local dockerls_config = {
                root_dir = nvim_lsp.util.root_pattern("Dockerfile",
                                                      "Dockerfile.dev")
            }

            local servers = {
                bashls = {},
                cssls = {},
                ccls = {},
                dockerls = dockerls_config,
                html = {},
                jsonls = {},
                lua_ls = {},
                marksman = {},
                pylsp = {},
                rust_analyzer = {},
                ruby_lsp = {},
                theme_check = {},
                ts_ls = {},
                yamlls = {}
            }

            local opts = {noremap = true, silent = true}

            -- LuaFormatter off
            vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
            -- LuaFormatter on

            local on_attach = function(client, bufnr)
                local function buf_set_keymap(...)
                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                end

                -- LuaFormatter off
                buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                buf_set_keymap('n', 'gt', '<cmd>lua require(\'lsp\').definition_new_tab()<CR>', opts)
                buf_set_keymap('n', 'gv', '<cmd>lua require(\'lsp\').definition_vsplit()<CR>', opts)
                buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
                buf_set_keymap('n', '<space>j', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
                buf_set_keymap('n', '<space>k', '<cmd>lua vim.lsp.buf.clear_references()<CR>', opts)

                vim.api.nvim_command [[ hi LspReferenceText ctermbg=8 ]]
                vim.api.nvim_command [[ hi LspReferenceWrite ctermbg=8 ]]
                vim.api.nvim_command [[ hi LspReferenceRead ctermbg=8 ]]
                -- LuaFormatter on
            end

            for lsp, lsp_config in pairs(servers) do
                nvim_lsp[lsp].setup(vim.tbl_extend("force", {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    flags = {debounce_text_changes = 150}
                }, lsp_config))
            end

            local signs = {
                Error = " ",
                Warn = " ",
                Hint = " ",
                Info = " "
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
            end
        end
    }
}
