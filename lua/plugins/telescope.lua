require('telescope').setup {}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>b', builtin.buffers, { noremap = true })
vim.keymap.set('n', '<C-p>', builtin.find_files, { noremap = true })
vim.keymap.set('n', '<C-f>', builtin.live_grep, { noremap = true })
vim.keymap.set('n', '<space>tt', builtin.builtin, { noremap = true })
