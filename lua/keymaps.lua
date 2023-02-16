_G.noremap = { noremap = true }
_G.silent = { silent = true }
_G.noremap_silent = { noremap = true, silent = true }

vim.api.nvim_set_keymap("i", "jk", "<Esc>", noremap_silent)
vim.api.nvim_set_keymap("x", "<Leader>c", [["+y]], silent)
vim.api.nvim_set_keymap("n", "<Leader>v", [["+p]], silent)

vim.api.nvim_set_keymap("n", "<C-6>", "<C-^>", noremap_silent)
vim.api.nvim_set_keymap("n", "<esc>", ":noh<return><esc>", noremap_silent)

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", noremap_silent)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", noremap_silent)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", noremap_silent)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", noremap_silent)

vim.api.nvim_set_keymap("n", "<C-q>", "<cmd>exe 'edit' stdpath('config').'/init.lua'<cr>", silent)
vim.api.nvim_set_keymap("n", "<C-Q>", "<cmd>exe 'edit' stdpath('config').'/init.lua'<CR>:cd %:h<CR>", silent)

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], silent)

vim.cmd.cabbrev("W", "w")
vim.cmd.cabbrev("Q", "q")
vim.cmd.cabbrev("Qa", "qa")
vim.cmd.cabbrev("QA", "qa")
