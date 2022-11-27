function _G.map(type, input, output)
	vim.api.nvim_set_keymap(type, input, output, {})
end

function _G.noremap(type, input, output)
	vim.api.nvim_set_keymap(type, input, output, { noremap = true, silent = true })
end

function _G.remap(type, input, output)
	vim.api.nvim_set_keymap(type, input, output, { noremap = false, silent = true })
end

function _G.nnoremap(input, output)
	noremap('n', input, output)
end

function _G.inoremap(input, output)
	noremap('i', input, output)
end

function _G.vnoremap(input, output)
	noremap('v', input, output)
end

function _G.xnoremap(input, output)
	noremap('x', input, output)
end

function _G.tnoremap(input, output)
	noremap('t', input, output)
end

function _G.nmap(input, output)
	remap('n', input, output)
end

function _G.imap(input, output)
	remap('i', input, output)
end

function _G.vmap(input, output)
	remap('v', input, output)
end

function _G.xmap(input, output)
	remap('x', input, output)
end

function _G.tmap(input, output)
	remap('t', input, output)
end

vim.g.mapleader = " "

inoremap("jk", "<Esc>")
xmap("<Leader>c", [["+y]])
nmap("<Leader>v", [["+p]])


nnoremap("<C-6>", "<C-^>")
nnoremap("<esc>", ":noh<return><esc>")

nmap("<C-j>", ":exe 'edit' stdpath('config').'/init.vim' <cr>")

tmap("<Esc><Esc>", [[<C-\><C-n>]])

vim.cmd "cabbrev W w"
