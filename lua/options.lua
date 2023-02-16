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

vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 100

vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
