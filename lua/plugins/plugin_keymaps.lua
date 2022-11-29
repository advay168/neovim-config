vim.g.mapleader = " "

-- derekwyatt/vim-fswitch
nmap("<leader>oh", ":FSLeft<CR>")
nmap("<leader>oH", ":FSSplitLeft<CR>")
nmap("<leader>ol", ":FSRight<CR>")
nmap("<leader>oL", ":FSSplitRight<CR>")
nmap("<leader>of", ":FSHere<CR>")

-- junegunn/fzf
--nmap("<leader>b", ":Buffers<CR>")
--nnoremap("<C-p>", ":GFiles<CR>")
--nnoremap("<C-M-p>", ":Files<CR>")

-- preservim/nerdcommenter
vim.g.NERDCommentEmptyLines = 1
nmap("<C-_>", "<Plug>NERDCommenterToggle")
xmap("<C-_>", "<Plug>NERDCommenterToggle")
