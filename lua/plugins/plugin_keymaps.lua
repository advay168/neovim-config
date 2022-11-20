vim.g.mapleader = " "

-- derekwyatt/vim-fswitch
nmap("<leader>oh", ":FSLeft<CR>")
nmap("<leader>oH", ":FSSplitLeft<CR>")
nmap("<leader>ol", ":FSRight<CR>")
nmap("<leader>oL", ":FSSplitRight<CR>")
nmap("<leader>of", ":FSHere<CR>")

-- junegunn/fzf
nmap("<leader>b", ":Buffers<CR>")
nnoremap("<C-p>", ":GFiles<CR>")
nnoremap("<C-M-p>", ":Files<CR>")

-- vim-airline/vim-airline
vim.g["airline#extensions#tabline#enabled"] = 1

-- preservim/nerdcommenter
vim.g.NERDCommentEmptyLines = 1
nmap("<C-_>", "<Plug>NERDCommenterToggle")
xmap("<C-_>", "<Plug>NERDCommenterToggle")

-- neoclide/coc.nvim
nmap("<leader>gd", "<Plug>(coc-definition)")
nmap("<leader>gy", "<Plug>(coc-type-definition)")
nmap("<leader>gi", "<Plug>(coc-implementation)")
nmap("<leader>gr", "<Plug>(coc-references)")

nmap("<leader>ac", "<Plug>(coc-codelens-action)")

nmap("<leader>fc", " <Plug>(coc-fix-current)")
nmap("<leader>fi", ":CocFix<CR>")
nmap("<leader>do", ":lopen<CR>")
nmap("<leader>dc", ":lclose<CR>")
nmap("<leader>dn", "<Plug>(coc-diagnostic-next)")
nmap("<leader>dp", "<Plug>(coc-diagnostic-prev)")

vim.g.coc_snippet_next = '<tab>'
vim.g.coc_snippet_prev = '<s-tab>'

nmap("<F2>", "<Plug>(coc-rename)")
vmap("<leader>f", " <Plug>(coc-format-selected)")
nmap("<leader>f", " <Plug>(coc-format-selected)")

vim.cmd "command! -nargs=0 Format :call CocAction('format')"
nmap("<C-A-f>", ":Format<CR>")

vim.cmd "command! -nargs=0 SetCWDasWS let b:coc_root_patterns='.'"


nnoremap("<leader>h", ":call CocActionAsync('doHover')<CR>")
