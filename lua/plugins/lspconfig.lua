return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- This is not a strict dependency for lspconfig
        -- but provides lsp extensions for omnisharp
        "Hoffs/omnisharp-extended-lsp.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local on_attach = function(client, bufnr)
            local function opts(desc)
                return { buffer = bufnr, desc = desc }
            end

            local map = vim.keymap.set

            map("n", "gD", vim.lsp.buf.declaration, opts("Find Declaration"))
            map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts("Find Definition"))
            -- BUG: This is being overwritten by built in `jump to last insert and highlight`
            map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts("Find Implementation"))
            map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts("Find Reference"))
            map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts("Find Type Definition"))
            map("n", "gI", "<cmd>Telescope lsp_incoming_calls<cr>", opts("Find Incoming Call"))
            map("n", "gO", "<cmd>Telescope lsp_outgoing_calls<cr>", opts("Find Outgoing Call"))
            map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", opts("Find Document Symbol"))
            map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", opts("Find Workspace Symbol"))
            map("n", "K", vim.lsp.buf.hover, opts("Show Hover"))

            map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("Code Action"))
            map("n", "<leader>ls", vim.lsp.buf.signature_help, opts("Show Signature Help"))
            map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, opts("Add Workspace Folder"))
            map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, opts("Remove Workspace Folder"))
            map("n", "<leader>lwl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts("List Workspace Folders"))

            map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))

            -- setup signature popup
            if client.server_capabilities.signatureHelpProvider then
                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = "single",
                })

                vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                    border = "single",
                    focusable = false,
                    relative = "cursor",
                    silent = true,
                })

                local check_triggeredChars = function(triggerChars)
                    local cur_line = vim.api.nvim_get_current_line()
                    local pos = vim.api.nvim_win_get_cursor(0)[2]

                    cur_line = cur_line:gsub("%s+$", "") -- rm trailing spaces

                    for _, char in ipairs(triggerChars) do
                        if cur_line:sub(pos, pos) == char then
                            return true
                        end
                    end
                end

                local group = vim.api.nvim_create_augroup("LspSignature", { clear = false })
                vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

                local triggerChars = client.server_capabilities.signatureHelpProvider.triggerCharacters

                vim.api.nvim_create_autocmd("TextChangedI", {
                    group = group,
                    buffer = bufnr,
                    callback = function()
                        if check_triggeredChars(triggerChars) then
                            vim.lsp.buf.signature_help()
                        end
                    end,
                })
            end
        end
        --    end

        local on_init = function(client, _)
            if client.supports_method("textDocument/semanticTokens") then
                client.server_capabilities.semanticTokensProvider = nil
            end
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local lspconfig = require("lspconfig")

        -- LUA

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            on_init = on_init,

            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "Snacks" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        })

        -- Markdown

        lspconfig.marksman.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- JSON

        lspconfig.jsonls.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- Bash
        lspconfig.bashls.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- C# / .NET

        lspconfig.omnisharp.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                -- omnisharp extended overrides
                -- stylua: ignore
                if client and client.name == "omnisharp" then
                    vim.keymap.set("n", "gd", require("omnisharp_extended").telescope_lsp_definition, { buffer = bufnr, desc = "Find Declaration" })
                    vim.keymap.set("n", "gt", require("omnisharp_extended").telescope_lsp_type_definition, { buffer = bufnr, desc = "Find Type Declaration" })
                    vim.keymap.set("n", "gr", require("omnisharp_extended").telescope_lsp_references, { buffer = bufnr, desc = "Find References" })
                    vim.keymap.set("n", "gi", require("omnisharp_extended").telescope_lsp_implementation, { buffer = bufnr, desc = "Find Implementation" })
                end
            end,
            on_init = on_init,
            capabilities = capabilities,
            cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
            filetypes = { "cs", "vb", "csproj", "sln", "slnx", "csx" },
            settings = {
                FormattingOptions = {
                    EnableEditorConfigSupport = true,
                    OrganizeImports = true,
                },
                RoslynExtensionsOptions = {
                    enableEditorConfigSupport = true,
                    EnableAnalyzersSupport = true,
                    EnableImportCompletion = true,
                },
            },
        })

        -- Docker

        lspconfig.docker_compose_language_service.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        lspconfig.dockerls.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- JAVASCRIPT / TYPESCRIPT / HTML / CSS

        lspconfig.cssls.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        lspconfig.html.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        lspconfig.ts_ls.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        lspconfig.tailwindcss.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
            settings = {
                tailwindCSS = {
                    experimental = {
                        classRegex = {
                            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                        },
                    },
                },
            },
        })

        lspconfig.eslint.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- Svelte
        --
        lspconfig.svelte.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- Cucumber

        lspconfig.cucumber_language_server.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
            settings = {
                cucumber = {
                    features = { "**/*.feature" },
                    glue = { "**/features/step_definitions/*.ts" },
                },
            },
        })

        -- GraphQL

        lspconfig.graphql.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- PYTHON

        lspconfig.basedpyright.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        lspconfig.ruff.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })

        -- RUST

        lspconfig.rust_analyzer.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                },
            },
        })

        -- TYPST

        lspconfig.tinymist.setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })
    end,
}
