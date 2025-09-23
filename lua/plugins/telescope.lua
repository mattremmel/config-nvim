return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
        config = function() end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        cmd = "Telescope",
        -- stylua: ignore
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fF", "<cmd>Telescope find_files hidden=true no-ignore=true<cr>", desc = "Find Files (+hidden)", },
            { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
            { "<leader>fW", "<cmd>lua require('telescope.builtin').live_grep{ additional_args = function(args) return vim.list_extend(args, { '--hidden', '--no-ignore' }) end}<cr>", desc = "Find Word (+hidden)", },
            { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find Text in Current Buffer" },
            { "<leader>fB", "<cmd>Telescope buffers<cr>", desc = "Find Open Buffers" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
            { "<leader>fH", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },
            { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find Plugin/User Commands" },
            { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Find Items in Quickfix List" },
            { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Find Items in Location List" },
            { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Find Entries in Jump List" },
            { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find Marks" },
            { "<leader>fgc", "<cmd>Telescope git_commits<cr>", desc = "Find Git Commits" },
            { "<leader>fgs", "<cmd>Telescope git_status<cr>", desc = "Find Git Status" },
        },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = "❯ ",
                path_display = { "truncate" },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },

                mappings = {
                    i = {
                        ["<C-n>"] = function(...)
                            return require("telescope.actions").cycle_history_next(...)
                        end,
                        ["<C-p>"] = function(...)
                            return require("telescope.actions").cycle_history_prev(...)
                        end,
                        ["<C-j>"] = function(...)
                            return require("telescope.actions").move_selection_next(...)
                        end,
                        ["<C-k>"] = function(...)
                            return require("telescope.actions").move_selection_previous(...)
                        end,
                        ["<C-t>"] = function(bufnr)
                            return require("trouble.sources.telescope").open(bufnr)
                        end,
                        ["<C-T>"] = function(bufnr)
                            return require("trouble.sources.telescope").add(bufnr)
                        end,
                    },
                    n = {
                        ["q"] = function(...)
                            require("telescope.actions").close(...)
                        end,
                        ["<C-t>"] = function(bufnr)
                            return require("trouble.sources.telescope").open(bufnr)
                        end,
                        ["<C-T>"] = function(bufnr)
                            return require("trouble.sources.telescope").add(bufnr)
                        end,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        "rg",
                        "--no-config",
                        "--follow",
                        "--files",
                        "--sortr=modified",
                    },
                },
            },
            extensions = {
                fzf = {},
            },
        },
        config = function(_, opts)
            -- Setup
            local telescope = require("telescope")
            telescope.setup(opts)

            -- Load extension
            telescope.load_extension("fzf")
        end,
    },
}
