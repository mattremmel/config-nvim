-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Add mason registry to path
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {

		-- ========================================================================
		-- COLORSCHEME
		-- ========================================================================

		{
			"EdenEast/nightfox.nvim",
			lazy = false,
			opts = {
				palettes = {
					nordfox = {
						bg0 = "#141414",
						bg1 = "#1f1f1f",
					},
				},
			},
		},

		-- ========================================================================
		-- CORE UTILITIES
		-- Multi-purpose plugins that provide foundational features
		-- ========================================================================

		{
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
			},
		},

		-- ========================================================================
		-- EDITOR ENHANCEMENTS
		-- Basic editing improvements and visual aids
		-- ========================================================================

		{
			"numToStr/Comment.nvim",
			event = { "BufReadPre", "BufNewFile" },
			opts = {},
		},

		{
			"windwp/nvim-autopairs",
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				fast_wrap = {},
				disable_filetypes = { "TelescopePrompt", "vim" },
			},
		},

		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				indent = {
					char = "│",
				},
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
				},
			},
		},

		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				preset = "helix",
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},

		-- ========================================================================
		-- UI COMPONENTS
		-- Status line, buffer line, and other UI elements
		-- ========================================================================

		{
			"akinsho/bufferline.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			event = "BufAdd",
			keys = {
				{ "L", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle to Next Buffer" },
				{ "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle to Previous Buffer" },
				{ ">b", "<cmd>BufferLineMoveNext<cr>", desc = "Re-order Current Buffer to Next Position" },
				{ "<b", "<cmd>BufferLineMovePrev<cr>", desc = "Re-order Current Buffer To Previous Position" },
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
		},

		{
			"nvim-lualine/lualine.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			event = "BufWinEnter",
			opts = {
				options = {
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
			},
		},

		-- ========================================================================
		-- NAVIGATION & FILE MANAGEMENT
		-- File explorers and window/pane navigation
		-- ========================================================================

		{
			"stevearc/oil.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			event = "VeryLazy",
			keys = {
				{ "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil File Manager" },
			},
			opts = {},
		},

		{
			"christoomey/vim-tmux-navigator",
			cmd = {
				"TmuxNavigateLeft",
				"TmuxNavigateDown",
				"TmuxNavigateUp",
				"TmuxNavigateRight",
				"TmuxNavigatePrevious",
			},
			keys = {
				{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Move to left window" },
				{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Move to bottom window" },
				{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Move to top window" },
				{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Move to right window" },
			},
		},

		-- ========================================================================
		-- SEARCH & DISCOVERY
		-- Fuzzy finders, diagnostics lists, and code navigation
		-- ========================================================================

		{
			"nvim-telescope/telescope-fzf-native.nvim",
			lazy = true,
			build = "make",
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
				{ "<leader>fF", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find Files (+hidden)", },
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
					prompt_prefix = " ",
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
				local telescope = require("telescope")
				telescope.setup(opts)
				telescope.load_extension("fzf")
			end,
		},

		{
			"folke/trouble.nvim",
			dependencies = "nvim-tree/nvim-web-devicons",
			cmd = { "Trouble" },
			-- stylua: ignore
			keys = {
				{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics (Trouble)" },
				{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
				{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
				{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
				{ "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References (Trouble)", },
				{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)", },
			},
			opts = {
				warn_no_results = false,
				open_no_results = true,
				focus = true,
			},
		},

		{
			"folke/todo-comments.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			event = { "BufReadPre", "BufNewFile" },
			cmd = { "TodoTelescope", "TodoTrouble" },
			keys = {
				{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODO Comments" },
				{
					"<leader>xt",
					"<cmd>Trouble todo toggle focus=true<cr>",
					desc = "TODO Comments (Trouble)",
				},
				{
					"]t",
					function()
						require("todo-comments").jump_next()
					end,
					desc = "Next TODO Comment",
				},
				{
					"[t",
					function()
						require("todo-comments").jump_prev()
					end,
					desc = "Previous TODO Comment",
				},
			},
			opts = {},
		},

		-- ========================================================================
		-- SYNTAX & TREESITTER
		-- Syntax highlighting and code parsing
		-- ========================================================================

		{
			"nvim-treesitter/nvim-treesitter",
			version = false,
			build = ":TSUpdate",
			event = { "BufReadPre", "BufNewFile" },
			cmd = { "TSUpdate", "TSModuleInfo" },
			main = "nvim-treesitter.config",
			opts = {
				ensure_installed = {
					"asm",
					"bash",
					"c",
					"c_sharp",
					"capnp",
					"cmake",
					"cpp",
					"css",
					"diff",
					"disassembly",
					"dockerfile",
					"dot",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"git_config",
					"git_rebase",
					"go",
					"graphql",
					"haskell",
					"hcl",
					"html",
					"http",
					"ini",
					"java",
					"javascript",
					"json",
					"json5",
					"jq",
					"just",
					"kotlin",
					"latex",
					"linkerscript",
					"llvm",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"nasm",
					"ninja",
					"nix",
					"objc",
					"objdump",
					"perl",
					"php",
					"proto",
					"python",
					"regex",
					"ron",
					"ruby",
					"rust",
					"scala",
					"scss",
					"sql",
					"ssh_config",
					"svelte",
					"swift",
					"terraform",
					"tmux",
					"toml",
					"tsx",
					"typescript",
					"typst",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
					"zig",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = { enable = true },
				indent = { enable = false },
			},
		},

		-- ========================================================================
		-- LSP & DEVELOPER TOOLS
		-- Language servers, formatters, and completion
		-- ========================================================================

		{
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
			opts = {
				ensure_installed = {
					-- LSP's
					"basedpyright",
					"bash-language-server",
					"css-lsp",
					"cucumber-language-server",
					"docker-compose-language-service",
					"dockerfile-language-server",
					"html-lsp",
					"graphql-language-service-cli",
					"json-lsp",
					"lua-language-server",
					"marksman",
					"omnisharp",
					"rust-analyzer",
					"svelte-language-server",
					"tailwindcss-language-server",
					"tinymist",
					"typescript-language-server",

					-- Linters
					"eslint-lsp",
					"ruff",

					-- Formatters
					"black",
					"isort",
					"prettierd",
					"stylua",

					-- Debuggers
					"codelldb",
				},
			},
			config = function(_, opts)
				require("mason").setup(opts)
				vim.api.nvim_create_user_command("MasonInstallAll", function()
					if opts.ensure_installed and #opts.ensure_installed > 0 then
						vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
					end
				end, {})
			end,
		},

		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				-- Lua LSP config
				vim.lsp.config("lua_ls", {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim", "Snacks" },
							},
							workspace = {
								library = {
									vim.fn.expand("$VIMRUNTIME/lua"),
									vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
									vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
								},
								maxPreload = 100000,
								preloadFileSize = 10000,
							},
						},
					},
				})

				-- Tailwind CSS config
				vim.lsp.config("tailwindcss", {
					root_markers = { "package.json", "tsconfig.json", ".git" },
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
									{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								},
							},
						},
					},
				})

				-- Cucumber config
				vim.lsp.config("cucumber_language_server", {
					settings = {
						cucumber = {
							features = { "**/*.feature" },
							glue = { "**/features/step_definitions/*.ts" },
						},
					},
				})

				-- Rust Analyzer config
				vim.lsp.config("rust_analyzer", {
					settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
						},
					},
				})

				-- Enable language servers
				vim.lsp.enable("lua_ls") -- Lua
				vim.lsp.enable("marksman") -- Markdown
				vim.lsp.enable("jsonls") -- JSON
				vim.lsp.enable("bashls") -- Bash
				vim.lsp.enable("docker_compose_language_service") -- Docker Compose
				vim.lsp.enable("dockerls") -- Dockerfile
				vim.lsp.enable("cssls") -- CSS
				vim.lsp.enable("html") -- HTML
				vim.lsp.enable("ts_ls") -- TypeScript/JavaScript
				vim.lsp.enable("tailwindcss") -- Tailwind CSS
				vim.lsp.enable("eslint") -- ESLint
				vim.lsp.enable("svelte") -- Svelte
				vim.lsp.enable("cucumber_language_server") -- Cucumber
				vim.lsp.enable("graphql") -- GraphQL
				vim.lsp.enable("basedpyright") -- Python
				vim.lsp.enable("ruff") -- Python linter
				vim.lsp.enable("rust_analyzer") -- Rust
				vim.lsp.enable("tinymist") -- Typst

				-- LSP keymaps (set when LSP attaches to buffer)
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local function opts(desc)
							return { buffer = args.buf, desc = desc }
						end

						-- Navigation (using Telescope)
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Find Declaration"))
						vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts("Find Definition"))
						vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts("Find Implementation"))
						vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts("Find Reference"))
						vim.keymap.set(
							"n",
							"gt",
							"<cmd>Telescope lsp_type_definitions<cr>",
							opts("Find Type Definition")
						)
						vim.keymap.set("n", "gI", "<cmd>Telescope lsp_incoming_calls<cr>", opts("Find Incoming Call"))
						vim.keymap.set("n", "gO", "<cmd>Telescope lsp_outgoing_calls<cr>", opts("Find Outgoing Call"))
						vim.keymap.set(
							"n",
							"<leader>fs",
							"<cmd>Telescope lsp_document_symbols<cr>",
							opts("Find Document Symbol")
						)
						vim.keymap.set(
							"n",
							"<leader>fS",
							"<cmd>Telescope lsp_workspace_symbols<cr>",
							opts("Find Workspace Symbol")
						)

						-- Hover & Help
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Show Hover"))
						vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts("Show Signature Help"))

						-- Code actions & Refactoring
						vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("Code Action"))
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))

						-- Workspace folders
						vim.keymap.set(
							"n",
							"<leader>lwa",
							vim.lsp.buf.add_workspace_folder,
							opts("Add Workspace Folder")
						)
						vim.keymap.set(
							"n",
							"<leader>lwr",
							vim.lsp.buf.remove_workspace_folder,
							opts("Remove Workspace Folder")
						)
						vim.keymap.set("n", "<leader>lwl", function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, opts("List Workspace Folders"))

						-- Diagnostics
						vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Previous Diagnostic"))
						vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Next Diagnostic"))
					end,
				})
			end,
		},

		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			keys = {
				{
					"<leader>rf",
					function()
						require("conform").format({ lsp_fallback = true })
					end,
					mode = "n",
					desc = "Format Buffer",
				},
			},
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					rust = { "rustfmt", lsp_format = "fallback" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					vue = { "prettierd" },
					css = { "prettierd" },
					scss = { "prettierd" },
					less = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					jsonc = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					["markdown.mdx"] = { "prettierd" },
					graphql = { "prettierd" },
					handlebars = { "prettierd" },
				},
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					else
						return {
							timeout_ms = 500,
							lsp_format = "fallback",
						}
					end
				end,
			},
			config = function(_, opts)
				require("conform").setup(opts)

				vim.api.nvim_create_user_command("FormatDisable", function(args)
					if args.bang then
						vim.g.disable_autoformat = true
					else
						vim.b.disable_autoformat = true
					end
				end, {
					desc = "Disable autoformat-on-save",
					bang = true,
				})

				vim.api.nvim_create_user_command("FormatEnable", function()
					vim.b.disable_autoformat = false
					vim.g.disable_autoformat = false
				end, {
					desc = "Re-enable autoformat-on-save",
				})
			end,
		},

		{
			"saghen/blink.cmp",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "1.*",
			event = "InsertEnter",
			opts = {
				keymap = { preset = "default" },
				appearance = {
					nerd_font_variant = "mono",
				},
				completion = {
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 200,
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
		},

		-- ========================================================================
		-- GIT INTEGRATION
		-- Version control tools and visualizations
		-- ========================================================================

		{
			"lewis6991/gitsigns.nvim",
			event = { "BufReadPre", "BufNewFile" },
			cmd = { "Gitsigns" },
			keys = {
				{ "<leader>gD", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle Deleted" },
				{
					"<leader>gn",
					function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							require("gitsigns").next_hunk()
						end)
						return "<Ignore>"
					end,
					expr = true,
					desc = "Next Hunk",
				},
				{
					"<leader>gp",
					function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							require("gitsigns").prev_hunk()
						end)
						return "<Ignore>"
					end,
					expr = true,
					desc = "Previous Hunk",
				},
				{ "ih", ":<C-U>Gitsigns select_hunk<cr>", mode = { "o", "x" }, desc = "Select Hunk" },
			},
			opts = {},
		},
	},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
})

-- Colorscheme
vim.o.background = "dark"
vim.cmd("colorscheme nordfox")

-- Subtle indent guides (set after colorscheme)
vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2e2e2e" })
vim.api.nvim_set_hl(0, "IblScope", { fg = "#3e3e3e" })

-- ============================================================================
-- BASIC SETTINGS
-- ============================================================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Display
vim.opt.cursorline = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "
vim.opt.linebreak = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.synmaxcol = 300

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

-- Behavior
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

-- Cursor
vim.opt.guicursor = "i-ci-ve:ver25"

-- Folding
vim.opt.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Command-line
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Diff
vim.opt.diffopt:append("linematch:60")

-- Performance
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })

-- Buffers
vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>", { noremap = true, silent = true, desc = "Write Buffer" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { noremap = true, silent = true, desc = "Quit Neovim" })

-- File navigation (visual line movement)
vim.keymap.set("n", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
vim.keymap.set("n", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })
vim.keymap.set("v", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
vim.keymap.set("v", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })

-- Inserting characters
vim.keymap.set("n", "<leader>;", "A;<esc>", { noremap = true, silent = true, desc = "Insert Semicolon at Line End" })
vim.keymap.set("n", "<leader>,", "A,<esc>", { noremap = true, silent = true, desc = "Insert Comma at Line End" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("v", "=", "=gv")

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

-- ============================================================================
-- DIAGNOSTICS
-- ============================================================================

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
