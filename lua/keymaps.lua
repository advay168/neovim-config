vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Escape" })
vim.api.nvim_set_keymap("x", "<Leader>c", [["+y]], { noremap = true, silent = true, desc = "Clipboard copy" })
vim.api.nvim_set_keymap("n", "<Leader>v", [["+p]], { noremap = true, silent = true, desc = "Clipboard paste" })

vim.api.nvim_set_keymap("n", "<C-6>", "<C-^>", { noremap = true, silent = true, desc = "Alternate file" })
vim.api.nvim_set_keymap("n", "<esc>", ":noh<return><esc>", { noremap = true, silent = true, desc = "Escape" })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Left window" })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Bottom window" })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Above window" })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Right window" })

vim.api.nvim_set_keymap("n", "<C-q>", "<cmd>exe 'edit' stdpath('config').'/init.lua'<CR>:cd %:h<CR>",
  { noremap = true, silent = true, desc = "Edit config" })

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Terminal escape" })

vim.cmd.cabbrev("W", "w")
vim.cmd.cabbrev("Q", "q")
vim.cmd.cabbrev("Qa", "qa")
vim.cmd.cabbrev("QA", "qa")
