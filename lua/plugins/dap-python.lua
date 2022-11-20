local dap = require('dap')

local dap_py = require("dap-python")

dap_py.setup("D:/dev/nvim-dap-data/debugpy.venv/Scripts/pythonw.exe")

dap.configurations.python[1].justMyCode = false
dap.configurations.python[1].redirectOutput = true
dap.configurations.python[1].showReturnValue = true
dap.configurations.python[2].justMyCode = false
dap.configurations.python[2].redirectOutput = true
dap.configurations.python[2].showReturnValue = true
dap.configurations.python[3].justMyCode = false
dap.configurations.python[3].redirectOutput = true
dap.configurations.python[3].showReturnValue = true
dap.configurations.python[4].justMyCode = false
dap.configurations.python[4].redirectOutput = true
dap.configurations.python[4].showReturnValue = true


--dap.defaults.fallback.focus_terminal = true
--dap.adapters.python = {
  --type = 'executable';
  --command = 'D:/dev/nvim-dap-data/debugpy.venv/Scripts/pythonw.exe';
  --args = { '-m', 'debugpy.adapter' };
--}
--
--dap.configurations.python = {
  --{
    ---- The first three options are required by nvim-dap
    --type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    --request = 'launch';
    --name = "Launch file";
--
    ---- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--
    --program = "${file}"; -- This configuration will launch the current file if used.
    --pythonPath = function()
      ---- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      ---- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      ---- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      --local cwd = vim.fn.getcwd()
      --if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        --return cwd .. '/venv/bin/python'
      --elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        --return cwd .. '/.venv/bin/python'
      --else
        --return 'C:/Windows/py.exe'
      --end
    --end;
  --},
--}
