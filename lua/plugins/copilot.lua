vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = false
vim.cmd [[imap <silent><script><expr> <C-J> copilot#Accept("")]]
vim.cmd [[command! Cen :let g:copilot_enabled=v:true]]
