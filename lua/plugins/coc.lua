--nmap("<leader>gd", "<Plug>(coc-definition)")
--nmap("<leader>gy", "<Plug>(coc-type-definition)")
--nmap("<leader>gi", "<Plug>(coc-implementation)")
--nmap("<leader>gr", "<Plug>(coc-references)")

nmap("<leader>gd", ":Telescope coc definitions<CR>")
nmap("<leader>gy", ":Telescope coc type_definitions<CR>")
nmap("<leader>gi", ":Telescope coc implementation<CR>")
nmap("<leader>gr", ":Telescope coc references<CR>")
nmap("<leader>ca", ":Telescope coc code_actions<CR>")

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
