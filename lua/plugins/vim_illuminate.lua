return {
    "rrethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("illuminate").configure({
            -- options
        })
    end,
}
