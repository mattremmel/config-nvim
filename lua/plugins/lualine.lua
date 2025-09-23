return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "BufWinEnter",
    opts = {
        options = {
            component_separators = "|",
            section_separators = { left = "", right = "" },
        },
    },
}
