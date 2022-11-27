nmap("<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>")

nmap("<leader>dc", ":lua require'dap'.run_to_cursor()<cr>")

nmap("<F6>", ":lua require'dap'.step_into()<cr>")
nmap("<F5>", ":lua require'dap'.continue()<cr>")
nmap("<F4>", ":lua require'dap'.step_out()<cr>")
nmap("<F3>", ":lua require'dap'.step_over()<cr>")

nmap("<leader>dh", ":lua require'dap'.pause()<cr>") -- halt
nmap("<leader>dr", ":lua require'dapui'.float_element('repl')<cr>")
nmap("<leader>dl", ":lua require'dap'.run_last()<cr>")
nmap("<leader>dq", ":lua require'dap'.close()<cr>")

nmap("<leader>dd", ":lua require'dapui'.toggle()<cr>")

