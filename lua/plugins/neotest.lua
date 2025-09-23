return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- adapters
        "Issafalcon/neotest-dotnet",
        "rouge8/neotest-rust",
    },
    keys = {
        { "<leader>vn", ":lua require('neotest').run.run()<cr>", desc = "Run Nearest Test" },
        { "<leader>vf", ":lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run All Tests In File" },
        { "<leader>vs", ":lua require('neotest').summary.toggle()<cr>", desc = "Toggle Testing Summary" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-dotnet")({
                    discovery_root = "solution",
                }),
                require("neotest-rust")({
                    args = { "--nocapture" }
                }),
            },
        })
    end,
}
