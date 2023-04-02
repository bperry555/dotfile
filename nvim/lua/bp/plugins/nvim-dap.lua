return {
    'mfussenegger/nvim-dap',
    config = function ()
        local dap = require('dap')

        dap.defaults.fallback.exception_breakpoints = {'all'}

        local mason_registry = require("mason-registry")
        local lldb_dap_root = mason_registry.get_package('codelldb'):get_install_path() .. '/extension/'
        local codelldb_path = lldb_dap_root .. 'adapter/codelldb'
        local liblldb_path = lldb_dap_root .. 'lldb/lib/liblldb.so'

        dap.adapters.rust = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)

        -- dap.adapters.lldb = {
           -- type = 'executable',
           -- command = '.vscode-server/extensions/vadimcn.vscode-lldb-1.9.0/lldb/bin',
           -- name = 'lldb'
        -- }

        local mason_registry = require("mason-registry")
        local cpp_dap_executable = mason_registry.get_package("cpptools"):get_install_path()
        .. "/extension/debugAdapters/bin/OpenDebugAD7"

        dap.adapters.cpp = {
            id = "cppdbg",
            type = "executable",
            command = cpp_dap_executable,
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = false,
                args = {},
            },
            --{
              --  name = 'Attach to gdbserver :1234',
               -- type = 'cppdbg',
               -- request = 'launch',
               -- MIMode = 'gdb',
               -- miDebuggerServerAddress = 'localhost:1234',
               -- miDebuggerPath = '/usr/bin/gdb',
               -- cwd = '${workspaceFolder}',
               -- program = function()
                --    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                -- end,
            --},
        }

        dap.configurations.lua = {
            {
                type = 'nlua',
                request = 'attach',
                name = 'attach to running Neovim instance',
            },
        }

        dap.adapters.nlua = function(callback, config)
            callback({
                type = "server",
                host = config.host or '127.0.0.1',
                port = config.port or 8086})
        end

        dap.configurations.c = dap.configurations.cpp

        vim.keymap.set("n", "<F6>", dap.step_into)
        vim.keymap.set("n", "<F7>", dap.step_over)
        vim.keymap.set("n", "<F8>", dap.step_out)
        vim.keymap.set("n", "<F9>", dap.continue)

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>cb", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
        end)
        vim.keymap.set("n", "<leader>lb", function()
            dap.list_breakpoints()
            vim.cmd.copen()
        end, { desc = "List breakpoints in quickfix list" })

        vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='🔵', texthl='', linehl='', numhl=''})

        local widgets = require("dap.ui.widgets")
        vim.keymap.set("n", "<leader>i", widgets.hover, {desc = "DAP Inspect"})
    end
}
