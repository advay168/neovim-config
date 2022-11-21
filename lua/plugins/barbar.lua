require("bufferline").setup({
  icons = webdev_icons_enabled
})

nmap("<A-,>", ":BufferPrevious<CR>")
nmap("<A-.>", ":BufferNext<CR>")

nmap("<A-1>", ":BufferGoto 1<CR>")
nmap("<A-2>", ":BufferGoto 2<CR>")
nmap("<A-3>", ":BufferGoto 3<CR>")
nmap("<A-4>", ":BufferGoto 4<CR>")
nmap("<A-5>", ":BufferGoto 5<CR>")
nmap("<A-6>", ":BufferGoto 6<CR>")
nmap("<A-7>", ":BufferGoto 7<CR>")
nmap("<A-8>", ":BufferGoto 8<CR>")
nmap("<A-9>", ":BufferGoto 9<CR>")
nmap("<A-0>", ":BufferLast<CR>")

nmap("<A-d>", ":BufferClose<CR>")
nmap("<A-p>", ":BufferPick<CR>")
