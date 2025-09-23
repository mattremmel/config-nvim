return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        statuscolumn = { enabled = true },
        quickfile = { enabled = true },
        words = { enabled = true },
        styles = {
            zen = {
                width = 180,
            },
        },
    },
        -- stylua: ignore
    keys = {
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        { "<leader>c", function() Snacks.bufdelete() end, desc = "Close Buffer" },
        { "<C-p>", function() Snacks.terminal() end, mode = {"n", "t"}, desc = "Toggle Terminal" },
        { "<leader>n",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>h",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>td", function() Snacks.terminal.toggle("lazydocker") end, desc = "Toggle Terminal" },
        { "<leader>tg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "<leader>ud", function() Snacks.toggle.dim() end, desc = "Toggle Dimming in Zen" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    }
,
}
