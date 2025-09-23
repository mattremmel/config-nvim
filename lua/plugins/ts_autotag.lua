return {
    "windwp/nvim-ts-autotag",
    ft = {
        "html",
        "xml",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "php",
        "mdx",
    },
    config = function()
        require("nvim-ts-autotag").setup()
    end,
}
