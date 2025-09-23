return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TodoTelescope", "TodoTrouble" },
    keys = {
        { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODO Comments" },
        {
            "<leader>xt",
            "<cmd>Trouble todo toggle focus=true<cr>",
            desc = "TODO Comments (Trouble)",
        },
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Next TODO Comment",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Previous TODO Comment",
        },
    },
    opts = {},
}
