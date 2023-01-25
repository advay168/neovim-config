vim.g.mapleader = " "

-- derekwyatt/vim-fswitch
nmap("<leader>oh", ":FSLeft<CR>")
nmap("<leader>oH", ":FSSplitLeft<CR>")
nmap("<leader>ol", ":FSRight<CR>")
nmap("<leader>oL", ":FSSplitRight<CR>")
nmap("<leader>of", ":FSHere<CR>")

-- preservim/nerdcommenter
vim.g.NERDCommentEmptyLines = 1
nmap("<C-_>", "<Plug>NERDCommenterToggle")
xmap("<C-_>", "<Plug>NERDCommenterToggle")

require("fidget").setup()

require("plugins.gruvbox")
require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.barbar")
require("plugins.tree-sitter")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.dap-common")
require("plugins.lsp")
require("plugins.null-ls")

require("plugins.copilot")
