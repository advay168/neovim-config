local function map(type, input, output)
	vim.api.nvim_set_keymap(type, input, output, {})
end

local function noremap(type, input, output)
	vim.api.nvim_set_keymap(type, input, output, { noremap = true, silent = true })
end

local function remap(type, input, output)
	vim.api.nvim_set_keymap(type, input, output, { noremap = false, silent = true })
end

local function nnoremap(input, output)
	noremap('n', input, output)
end

local function inoremap(input, output)
	noremap('i', input, output)
end

local function vnoremap(input, output)
	noremap('v', input, output)
end

local function xnoremap(input, output)
	noremap('x', input, output)
end

local function nmap(input, output)
	remap('n', input, output)
end

local function imap(input, output)
	remap('i', input, output)
end

local function vmap(input, output)
	remap('v', input, output)
end

local function xmap(input, output)
	remap('x', input, output)
end

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

vim.g.NERDTreeQuitOnOpen=1
nmap("<leader>ne", ":NERDTreeToggle<CR>")

-- Badhi/nvim-treesitter-cpp-tools
nmap("<leader>df", ":TSCppDefineClassFunc<cr>")
xmap("<leader>df", ":TSCppDefineClassFunc<cr>")

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


nnoremap("<silent><leader>h", ":call CocActionAsync('doHover')<CR>")
