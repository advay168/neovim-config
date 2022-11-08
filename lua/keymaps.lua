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

inoremap("jk", "<Esc>")
xmap("<Leader>c", [["+y]])
nmap("<Leader>v", [["+p]])


nnoremap("<C-6>", "<C-^>")
nnoremap("<esc>", ":noh<return><esc>")

nmap("<C-j>", ":exe 'edit' stdpath('config').'/init.vim' <cr>")
