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
vim.opt.spelllang = "en_gb"
vim.opt.backspace = "indent,eol,start"
vim.opt.scrolloff = 7
vim.opt.mouse = "a"
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"

vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2

vim.cmd [[
  autocmd FileType python setlocal shiftwidth=4
]]

vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.cmd [[autocmd  TextYankPost * silent! lua vim.highlight.on_yank()]]

vim.opt.list = true
vim.opt.listchars = {
  tab = "⇥ ",
  leadmultispace = "┊ ",
  trail = "␣",
  nbsp = "⍽",
  precedes = "<",
  extends = ">",
  space = " ",
}
local function update_lead()
    local lcs = vim.opt_local.listchars:get()
    local tab = vim.fn.str2list(lcs.tab)
    local space = vim.fn.str2list(lcs.multispace or lcs.space)
    local lead = {tab[1]}
    for i = 1, vim.bo.tabstop-1 do
        lead[#lead+1] = space[i % #space + 1]
    end
    vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })
end
local group = vim.api.nvim_create_augroup("indentline", {})
vim.api.nvim_create_autocmd("OptionSet", { group = group, pattern = { "listchars", "tabstop", "filetype" }, callback = update_lead })
vim.api.nvim_create_autocmd("VimEnter", { group = group, callback = update_lead, once = true })

local statusline = {
  ' %t',
  '%r',
  '%m',
  '%=',
  '%{&filetype}',
  ' %2p%%',
  ' %3l:%-2c '
}

vim.o.statusline = table.concat(statusline, '')
