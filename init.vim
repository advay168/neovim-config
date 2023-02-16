let mapleader = " "

augroup pythonFile
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal shiftwidth=4
augroup END

if (has("termguicolors"))
  set termguicolors
endif

lua require("init")
" ./lua/init.lua
