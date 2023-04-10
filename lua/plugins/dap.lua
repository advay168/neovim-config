return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true
      }
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end },
      { "<leader>dc", function() require("dap").run_to_cursor() end },
      { "<F6>",       function() require("dap").step_into() end },
      { "<F5>",       function() require("dap").continue({}) end },
      { "<F4>",       function() require("dap").step_out() end },
      { "<F3>",       function() require("dap").step_over() end },
      { "<leader>dh", function() require("dap").pause() end },
      { "<leader>dr", function() require("dapui").float_element("repl", {}) end },
      { "<leader>dl", function() require("dap").run_last() end },
      { "<leader>dq", function() require("dap").close() end },
      { "<leader>dd", function() require("dapui").toggle({}) end },
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

      local dap_py = require("dap-python")
      dap_py.setup("D:/dev/nvim-dap-data/debugpy.venv/Scripts/pythonw.exe")

      local dap = require("dap")
      for _, conf in ipairs(dap.configurations.python) do
        conf.justMyCode = false
        conf.redirectOutput = true
        conf.showReturnValue = true
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "D:/dev/nvim-dap-data/codelldb/extension/adapter/codelldb.exe",
          args = { "--port", "${port}" },

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
            ---@diagnostic disable-next-line: redundant-parameter, param-type-mismatch
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
      local dapui = require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "stacks",      size = 0.29 },
              { id = "scopes",      size = 0.30 },
              { id = "breakpoints", size = 0.16 },
              { id = "watches",     size = 0.25 },
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
          border = "rounded", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        }
      }
      )

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end

  },
}
