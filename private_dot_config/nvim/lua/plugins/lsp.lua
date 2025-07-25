return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    }, {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {"williamboman/mason.nvim"},
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls", "clangd", "cssls", "dockerls", "html", "jsonls",
                    "lua_ls", "marksman", "pyright", "rust_analyzer",
                    "ruby_lsp", "theme_check", "ts_ls", "yamlls", "gopls"
                },
                automatic_installation = true
            })
        end
    }, {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            local nvim_lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Enhanced capabilities
            capabilities.textDocument.completion.completionItem = {
                documentationFormat = {"markdown", "plaintext"},
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = {valueSet = {1}},
                resolveSupport = {
                    properties = {
                        "documentation", "detail", "additionalTextEdits"
                    }
                }
            }

            vim.o.completeopt = "menu,menuone,noselect"

            local servers = {
                bashls = {filetypes = {"sh", "bash", "zsh"}},
                clangd = {
                    cmd = {
                        "clangd", "--background-index", "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders"
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true
                    }
                },
                cssls = {
                    settings = {
                        css = {
                            validate = true,
                            lint = {
                                unknownAtRules = "warning",
                                duplicateProperties = "warning",
                                emptyRules = "warning"
                            }
                        },
                        scss = {
                            validate = true,
                            lint = {
                                unknownAtRules = "warning",
                                duplicateProperties = "warning",
                                emptyRules = "warning"
                            }
                        },
                        less = {
                            validate = true,
                            lint = {
                                unknownAtRules = "warning",
                                duplicateProperties = "warning",
                                emptyRules = "warning"
                            }
                        }
                    }
                },
                dockerls = {
                    root_dir = nvim_lsp.util.root_pattern("Dockerfile",
                                                          "Dockerfile.*",
                                                          "docker-compose.yml",
                                                          "docker-compose.yaml")
                },
                html = {
                    init_options = {
                        configurationSection = {"html", "css", "javascript"},
                        embeddedLanguages = {css = true, javascript = true},
                        provideFormatter = true
                    }
                },
                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = {enable = true}
                        }
                    }
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {version = "LuaJIT"},
                            diagnostics = {globals = {"vim", "require"}},
                            workspace = {
                                library = vim.api
                                    .nvim_get_runtime_file("", true),
                                checkThirdParty = false
                            },
                            telemetry = {enable = false},
                            format = {enable = false}
                        }
                    }
                },
                marksman = {},
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly",
                                useLibraryCodeForTypes = true,
                                typeCheckingMode = "standard",
                                autoImportCompletions = true,
                                diagnosticSeverityOverrides = {
                                    reportMissingTypeStubs = "information",
                                    reportPrivateImportUsage = "warning"
                                }
                            }
                        }
                    }
                },
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true
                            },
                            checkOnSave = {
                                allFeatures = true,
                                command = "clippy",
                                extraArgs = {"--no-deps"}
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = {"async_trait"},
                                    ["napi-derive"] = {"napi"},
                                    ["async-recursion"] = {"async_recursion"}
                                }
                            },
                            inlayHints = {
                                bindingModeHints = {enable = false},
                                chainingHints = {enable = true},
                                closingBraceHints = {
                                    enable = true,
                                    minLines = 25
                                },
                                parameterHints = {enable = true},
                                typeHints = {
                                    enable = true,
                                    hideClosureInitialization = false,
                                    hideNamedConstructor = false
                                }
                            },
                            lens = {
                                enable = true,
                                implementations = true,
                                references = true,
                                methodReferences = true,
                                enumVariantReferences = true
                            },
                            completion = {
                                autoimport = {enable = true},
                                postfix = {enable = true}
                            }
                        }
                    }
                },
                ruby_lsp = {init_options = {formatter = "auto"}},
                theme_check = {},
                ts_ls = {
                    init_options = {
                        preferences = {
                            disableSuggestions = false,
                            includeInlayParameterNameHints = "literals",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = false,
                            includeInlayPropertyDeclarationTypeHints = false,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true
                        }
                    },
                    settings = {
                        typescript = {
                            suggest = {
                                autoImports = true,
                                completeFunctionCalls = true,
                                includeCompletionsForImportStatements = true
                            },
                            format = {enable = false}
                        },
                        javascript = {
                            suggest = {
                                autoImports = true,
                                completeFunctionCalls = true,
                                includeCompletionsForImportStatements = true
                            },
                            format = {enable = false}
                        }
                    }
                },
                yamlls = {
                    settings = {
                        yaml = {
                            hover = true,
                            completion = true,
                            validate = true,
                            schemas = {
                                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml"
                            }
                        }
                    }
                },
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = false,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = false
                            },
                            hints = {
                                assignVariableTypes = false,
                                compositeLiteralFields = false,
                                compositeLiteralTypes = false,
                                constantValues = false,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = false
                            },
                            analyses = {
                                fieldalignment = false,
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = {
                                "-.git", "-.vscode", "-.idea", "-.vscode-test",
                                "-node_modules", "-vendor"
                            },
                            semanticTokens = true,
                            buildFlags = {"-tags=integration,unit"}
                        }
                    }
                }
            }

            local opts = {noremap = true, silent = true}

            -- Global mappings
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[g', function()
                vim.diagnostic.jump({count = -1, float = true})
            end, opts)
            vim.keymap.set('n', ']g', function()
                vim.diagnostic.jump({count = 1, float = true})
            end, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                local function buf_set_keymap(mode, lhs, rhs)
                    vim.keymap.set(mode, lhs, rhs, {
                        buffer = bufnr,
                        noremap = true,
                        silent = true
                    })
                end

                -- Enable completion triggered by <c-x><c-o>
                vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Disable formatting for specific LSPs (we use formatter.nvim)
                if client.name == "ts_ls" or client.name == "html" or
                    client.name == "jsonls" or client.name == "yamlls" then
                    client.server_capabilities.documentFormattingProvider =
                        false
                    client.server_capabilities.documentRangeFormattingProvider =
                        false
                end

                -- Mappings
                buf_set_keymap('n', 'gD', vim.lsp.buf.declaration)
                buf_set_keymap('n', 'gd', vim.lsp.buf.definition)
                buf_set_keymap('n', 'gt',
                               '<cmd>lua require(\'lsp\').definition_new_tab()<CR>')
                buf_set_keymap('n', 'gv',
                               '<cmd>lua require(\'lsp\').definition_vsplit()<CR>')
                buf_set_keymap('n', 'K', vim.lsp.buf.hover)
                buf_set_keymap('n', 'gi', vim.lsp.buf.implementation)
                buf_set_keymap('n', 'gK', vim.lsp.buf.signature_help)
                buf_set_keymap('n', '<space>wa',
                               vim.lsp.buf.add_workspace_folder)
                buf_set_keymap('n', '<space>wr',
                               vim.lsp.buf.remove_workspace_folder)
                buf_set_keymap('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end)
                buf_set_keymap('n', '<space>D', vim.lsp.buf.type_definition)
                buf_set_keymap('n', '<space>rn', vim.lsp.buf.rename)
                buf_set_keymap('n', '<space>ca', vim.lsp.buf.code_action)
                buf_set_keymap('n', 'gr', vim.lsp.buf.references)
                buf_set_keymap('n', '<space>f', function()
                    vim.lsp.buf.format({async = true})
                end)
                buf_set_keymap('n', '<space>j', vim.lsp.buf.document_highlight)
                buf_set_keymap('n', '<space>k', vim.lsp.buf.clear_references)

                -- Set up highlight groups for references
                vim.cmd [[ hi LspReferenceText ctermbg=8 guibg=#3c3836 ]]
                vim.cmd [[ hi LspReferenceWrite ctermbg=8 guibg=#3c3836 ]]
                vim.cmd [[ hi LspReferenceRead ctermbg=8 guibg=#3c3836 ]]
            end

            -- Enhanced diagnostics configuration
            vim.diagnostic.config({
                virtual_text = {prefix = "●", spacing = 4, source = "if_many"},
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = ""
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                        [vim.diagnostic.severity.HINT] = "󰠠 "
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
                        [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
                        [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint"
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint"
                    }
                },
                update_in_insert = false,
                underline = true,
                severity_sort = true
            })

            -- Set up LSP servers
            for lsp, lsp_config in pairs(servers) do
                nvim_lsp[lsp].setup(vim.tbl_extend("force", {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    flags = {debounce_text_changes = 150}
                }, lsp_config))
            end

            -- Additional UI customization for LSP
            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                                                                 vim.lsp
                                                                     .handlers
                                                                     .signature_help,
                                                                 {
                    border = "rounded"
                })
        end
    }, {"b0o/schemastore.nvim", lazy = true}
}
