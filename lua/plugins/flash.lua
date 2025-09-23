return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
    config = function(_, opts)
        require("flash").setup(opts)
        vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#000000", bg = "#ffff00", bold = true })
        vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#00ff00", bg = "none", bold = false })
        vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#00ff00", bg = "none", bold = false })
    end,
}
