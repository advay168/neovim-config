if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

vim.opt.encoding = "utf-8"
vim.opt.fileformats = "unix,dos"
vim.opt.fileformat = "unix"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backspace = "indent,eol,start"
vim.opt.scrolloff = 7
vim.opt.mouse = "a"
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"

vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.cmd [[
  autocmd FileType python setlocal shiftwidth=4
]]

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 100

vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]
