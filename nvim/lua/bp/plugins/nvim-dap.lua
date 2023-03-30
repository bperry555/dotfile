return {
    'mfussenegger/nvim-dap',
    config = function ()
        local dap = require('dap')

        dap.adapters.llb = {
            type = 'executable',
            command = '.vscode-server/extensions/vadimcn.vscode-lldb-1.9.0/lldb/bin',
            name = 'lldb'
        }


--        dap.adapters.cppdbg = {
--            id = 'cppdbg',
--            type = 'executable',
--            command = vim.env.HOME .. '/.vscode-server/extensions/ms-vscode.cpptools-1.14.5-linux-x64/debugAdapters/bin/OpenDebugAD7',
            -- command = '\\\wsl.localhost\\Ubuntu\\home\\brian\\.vscode-server\\extensions\\ms-vscode.cpptools-1.14.5-linux-x64\\debugAdapters\\bin\\OpenDebugAD7',
--        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "lldb",
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

        dap.adapters.nlua = function(callback, config)
            callback({
                type = "server",
                host = config.host,
                port = config.host,
            })
        end

        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
    end
}
