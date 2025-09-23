return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
        -- TODO: Pact ls, snyk, sql, typst, yamlls
        ensure_installed = {
            -- LSP's
            "basedpyright",
            "bash-language-server",
            "css-lsp",
            "cucumber-language-server",
            "docker-compose-language-service",
            "dockerfile-language-server",
            "html-lsp",
            "graphql-language-service-cli",
            "json-lsp",
            "lua-language-server",
            "marksman",
            "omnisharp",
            "rust-analyzer",
            "svelte-language-server",
            "tailwindcss-language-server",
            "tinymist",
            "typescript-language-server",

            -- Linters
            "eslint-lsp",
            "ruff",

            -- Formatters
            "black",
            "isort",
            "prettierd",
            "stylua",

            -- Debuggers
            "codelldb",
        },
        automatic_installation = true,
    },
    config = function(_, opts)
        require("mason").setup(opts)
        vim.api.nvim_create_user_command("MasonInstallAll", function()
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end
        end, {})
    end,
}
