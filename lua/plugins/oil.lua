return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    events = { "VeryLazy" },
    keys = {
        { "<leader>e", "<cmd>Oil<cr>", { desc = "Open Oil File Manager" } },
    },
    opts = {},
}
