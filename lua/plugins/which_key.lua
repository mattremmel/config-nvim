return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function(_, opts)
        vim.o.timeout = true
        vim.o.timeoutlen = 300

        local which_key = require("which-key")
        which_key.setup(opts)
        which_key.add({
            { "<leader>d", group = "Debugging" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>l", group = "LSP" },
            { "<leader>q", group = "Quit" },
            { "<leader>r", group = "Refactor" },
            { "<leader>t", group = "Terminal" },
            { "<leader>v", group = "Validation" },
            { "<leader>x", group = "Trouble" },
        })
    end,
}
