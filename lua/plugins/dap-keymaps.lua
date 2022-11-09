nmap("<leader>dt", ":lua require'dap'.toggle_breakpoint()<cr>")

nmap("<leader>dc", ":lua require'dap'.continue()<cr>")
nmap("<leader>dC", ":lua require'dap'.run_to_cursor()<cr>")

nmap("<leader>di", ":lua require'dap'.step_into()<cr>")
nmap("<leader>do", ":lua require'dap'.step_over()<cr>")
nmap("<leader>du", ":lua require'dap'.step_out()<cr>")

nmap("<leader>dp", ":lua require'dap'.pause()<cr>")
nmap("<leader>dr", ":lua require'dap'.repl.toggle()<cr>")
nmap("<leader>ds", ":lua require'dap'.continue()<cr>")
nmap("<leader>dl", ":lua require'dap'.run_last()<cr>")
nmap("<leader>dq", ":lua require'dap'.close()<cr>")

nmap("<leader>dd", ":lua require'dapui'.toggle()<cr>")
