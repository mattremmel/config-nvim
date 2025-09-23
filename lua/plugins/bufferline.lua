return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "BufAdd",
    keys = {
        { "L", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle to Next Buffer" },
        { "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle to Previous Buffer" },
        { ">b", "<cmd>BufferLineMoveNext<cr>", desc = "Re-order Current Buffer to Next Position" },
        { "<b", "<cmd>BufferLineCyclePrev<cr>", desc = "Re-order Current Buffer To Previous Position" },
    },
    opts = {
        options = {
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "PanelHeading",
                },
            },
        },
    },
}
