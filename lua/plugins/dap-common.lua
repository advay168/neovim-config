local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
require("plugins.dap-keymaps")

require("plugins.dap-python")
require("plugins.dap-cpp")

local dapui = require("dapui")
dapui.setup({
  layouts = {
    {
      elements = {
        { id = "stacks", size = 0.29 },
        { id = "scopes", size = 0.30 },
        { id = "breakpoints", size = 0.16 },
        { id = "watches", size = 0.25 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = {
        { id = "repl", size = 0.45 },
        --{ id = "console", size = 0.55 },
      },
      size = 0.25,
      position = "bottom",
    },
  },
  floating = {
    max_width = 0.5, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be 'single', 'double' or 'rounded'
    mappings = {
      close = { "q", "<Esc>" },
    },
  }}
  )

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
