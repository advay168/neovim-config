local dap_py = require("dap-python")
dap_py.setup("D:/dev/nvim-dap-data/debugpy.venv/Scripts/pythonw.exe")

local dap = require('dap')
for _, conf in ipairs(dap.configurations.python) do
  conf.justMyCode = false
  conf.redirectOutput = true
  conf.showReturnValue = true
end
