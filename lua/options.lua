local opt = vim.opt

opt.encoding = "utf-8"
opt.fileformats = "unix,dos"
opt.fileformat = "unix"
opt.number = true
opt.relativenumber = true
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.backspace = "indent,eol,start"
opt.scrolloff = 7
opt.mouse = "a"

-- opt.clipboard:append("unnamedplus")

opt.tabstop=2
opt.softtabstop=2
opt.shiftwidth=2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 100

opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
