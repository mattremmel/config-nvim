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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Colorscheme
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
    -- Tmux Navigator
    {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
},
    -- Autopairs
    {
      "windwp/nvim-autopairs",
      event = { "BufReadPre", "BufNewFile" },
      opts = {
        fast_wrap = {},
        disable_filetypes = { "TelescopePrompt", "vim" },
      },
    },
    -- Snacks
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
    }
},
-- Comment
{
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
},
    -- Bufferline,
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
    },
    -- Lualine
    {
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
    },
    -- Oil
    {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    events = { "VeryLazy" },
    keys = {
        { "<leader>e", "<cmd>Oil<cr>", { desc = "Open Oil File Manager" } },
    },
    opts = {},
},
    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      version = false,
      build = ":TSUpdate",
      event = { "BufReadPre", "BufNewFile" },
      cmd = { "TSUpdate", "TSModuleInfo" },
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
        rainbow = {
          enable = true,
          disable = { "html" },
          extended_mode = false,
          max_file_lines = nil,
        },
        incremental_selection = { enable = true },
        indent = { enable = false },
      },
    },
    -- Telescope
{

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
},
-- Trouble
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
-- Todo Comments
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
  checker = { enabled = true },
})

-- Colorscheme
vim.o.background = "dark"
vim.cmd("colorscheme nordfox")

-- Basic settings
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = false -- Highlight current line
vim.opt.wrap = true -- Wrap lines
vim.opt.breakindent = true
vim.opt.showbreak = "↪ " -- Make long lines wrap smartly
vim.opt.linebreak = true
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.hlsearch = false -- Don't highlight search results
vim.opt.incsearch = true -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = "yes" -- Always show sign column
-- vim.opt.colorcolumn = "100" -- Show column at 100 characters
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- Don't hide cursor line markup
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save

-- Behavior settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding

-- Cursor settings
vim.opt.guicursor = "i-ci-ve:ver25"

-- Folding settings
vim.opt.foldmethod = "expr" -- Use expression for folding
vim.wo.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Start with all folds open

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })

-- buffers
vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>", { noremap = true, silent = true, desc = "Write Buffer" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { noremap = true, silent = true, desc = "Quit Neovim" })

-- File navigation
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

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Move to right window" })

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
vim.keymap.set("v", "=", "=gv") -- don't lose selection when indenting

-- Quick file navigation
-- vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
-- vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================

-- WARN: This way of setting signs is deprecated
-- Diagnostic signs
vim.fn.sign_define(
    "DiagnosticSignError",
    { texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "DiagnosticSignInfo" })

-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end)

-- Basic autocommands
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
