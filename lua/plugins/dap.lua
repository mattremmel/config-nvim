return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },

        -- stylua: ignore
        keys = {
            { '<leader>dt', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
            { '<leader>db', function() require('dap').set_breakpoint() end, desc = 'Set Breakpoint' },
            { '<leader>dr', function() require('dap').repl.open() end, desc = 'Open REPL' },
            { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
            { '<leader>dn', function() require('dap').continue() end, desc = 'Continue' },
            { '<leader>do', function() require('dap').step_over() end, desc = 'Step Over' },
            { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
            { '<leader>dO', function() require('dap').step_out() end, desc = 'Step Out' },
            { '<leader>dh', mode = { 'n', 'v' }, function() require('dap.ui.widgets').hover() end, desc = 'Inspect (Hover)' },
            { '<leader>dp', mode = { 'n', 'v' }, function() require('dap.ui.widgets').preview() end, desc = 'Preview' },
            { '<leader>df',
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.frames)
                end, desc = 'Show Frames'
            },
            { '<leader>ds',
                function()
                    local widgets = require('dap.ui.widgets')
                    widgets.centered_float(widgets.scopes)
                end, desc = 'Show Scopes'
            },
        },
    config = function()
        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "🔵", texthl = "", linehl = "", numhl = "" })

        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        local mason_registry = require("mason-registry")

        -- codelldb
        local codelldb_path = mason_registry.get_package("codelldb"):get_install_path()
        local codelldb_cmd = codelldb_path .. "/extension/adapter/codelldb"

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = codelldb_cmd,
                args = { "--port", "${port}" },
            },
        }

        -- rust
        -- dap.configurations.rust = {
        --     {
        --         name = "Launch",
        --         type = "codelldb",
        --         request = "launch",
        --         program = function()
        --             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopOnEntry = false,
        --         args = {},
        --         preLaunchTask = function()
        --             vim.fn.system("cargo build")
        --         end,
        --     },
        --     {
        --         name = "Test",
        --         type = "codelldb",
        --         request = "launch",
        --         program = function()
        --             local cwd = vim.fn.getcwd()
        --             local test_executables = vim.fn.glob(cwd .. "/target/debug/deps/*", 0, 1)
        --
        --             -- Filter out files with extensions and create a unique set of crate names
        --             local unique_crates = {}
        --             local filtered_test_executables = {}
        --             for _, file in ipairs(test_executables) do
        --                 local crate_name = file:match("^.+/(.-)%-[%w%-]+$")
        --                 if crate_name and not unique_crates[crate_name] and not file:match("^.+%.%w+$") then
        --                     unique_crates[crate_name] = true
        --                     table.insert(filtered_test_executables, file)
        --                 end
        --             end
        --
        --             table.sort(filtered_test_executables, function(a, b)
        --                 return vim.fn.getftime(a) > vim.fn.getftime(b)
        --             end)
        --
        --             local choices = vim.tbl_map(function(item)
        --                 return item:match("^.+/(.+)$")
        --             end, filtered_test_executables)
        --             local choice = vim.fn.inputlist(choices)
        --             return filtered_test_executables[choice]
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopOnEntry = false,
        --         args = { "--nocapture" },
        --         env = function()
        --             return {
        --                 ["RUST_BACKTRACE"] = "1",
        --             }
        --         end,
        --         preLaunchTask = function()
        --             vim.fn.system("cargo test --no-run")
        --         end,
        --     },
        -- }
    end,
}
