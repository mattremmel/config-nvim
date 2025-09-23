return {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        fast_wrap = {},
        disable_filetypes = { "TelescopePrompt", "vim" },
    },
}
