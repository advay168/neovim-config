local dap = require('dap')

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = 'D:/dev/nvim-dap-data/codelldb/extension/adapter/codelldb.exe',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
  },
}



--dap.adapters.lldb = {
  --type = 'executable',
  --command = 'D:/dev/llvm-project/build/Release/bin/lldb-vscode.exe', -- adjust as needed, must be absolute path
  --name = 'lldb'
--}
--
--dap.configurations.cpp = {
  --{
    --name = 'Launch',
    --type = 'lldb',
    --request = 'launch',
    --program = function()
      --return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --end,
    --cwd = '${workspaceFolder}',
    --stopOnEntry = false,
    --args = {},
    --debuggerRoot = '${workspaceFolder}',
  --},
--}

--dap.adapters.cppdbg = {
  --id = 'cppdbg',
  --type = 'executable',
  --command = "D:/dev/nvim-dap-data/cpptools/extension/debugAdapters/bin/OpenDebugAD7.exe",
  --options = {
    --detached = false
  --}
--}
--
--dap.configurations.cpp = {
  --{
    --name = "Launch file",
    --type = "cppdbg",
    --request = "launch",
    --program = function()
      --return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --end,
    --cwd = '${workspaceFolder}',
    --stopAtEntry = true,
  --},
  --{
    --name = 'Attach to gdbserver :1234',
    --type = 'cppdbg',
    --request = 'launch',
    --MIMode = 'gdb',
    --miDebuggerServerAddress = 'localhost:1234',
    --miDebuggerPath = '/usr/bin/gdb',
    --cwd = '${workspaceFolder}',
    --program = function()
      --return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --end,
  --},
--}



--dap.adapters.codelldb = {
  --type = 'server',
  --host = '127.0.0.1',
  --port = 13000 -- 💀 Use the port printed out or specified with `--port`
--}

