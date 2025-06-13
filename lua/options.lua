if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

vim.opt.encoding = "utf-8"
vim.opt.fileformats = "unix,dos"
vim.opt.fileformat = "unix"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spelllang = "en_gb"
vim.opt.backspace = "indent,eol,start"
vim.opt.scrolloff = 7
vim.opt.mouse = "a"
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"
vim.opt.nrformats:append("alpha")

vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldtext = ''
vim.o.foldenable = true
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldmethod = 'expr'
-- TODO
print("Add lsp folding")

if os.getenv("wt") == "1" then
  -- vim.o.fillchars = 'fold: ,foldopen:,foldsep: ,foldclose:'
  vim.o.fillchars = 'foldopen:,foldclose:'
end


vim.cmd [[
  autocmd FileType python setlocal shiftwidth=4
]]

vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.cmd [[autocmd  TextYankPost * silent! lua vim.highlight.on_yank()]]

--[[ vim.opt.list = true
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
    local leadmultispace = vim.fn.str2list(lcs.leadmultispace)
    local space = vim.fn.str2list(lcs.multispace or lcs.space)
    local lead = {leadmultispace[1]}
    for i = 1, vim.bo.tabstop-1 do
        lead[#lead+1] = space[i % #space + 1]
    end
    vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })
end
local group = vim.api.nvim_create_augroup("indentline", {})
vim.api.nvim_create_autocmd("OptionSet", { group = group, pattern = { "listchars", "tabstop", "filetype" }, callback = update_lead })
vim.api.nvim_create_autocmd("VimEnter", { group = group, callback = update_lead, once = true }) ]]

local statusline = {
  ' %t',
  '%r',
  '%m',
  '%=',
  '%{&filetype}',
  ' %2p%%',
  ' %3l:%-2c '
}

vim.o.laststatus = 3
vim.o.statusline = table.concat(statusline, '')

vim.cmd [[
function! SetStatusLine()
  set statusline=
  set statusline+=%{b:gitbranch}
  set statusline+=\ 
  if &columns < 90
    set statusline+=%f
  else
    set statusline+=%F
    endif
    set statusline+=%m
    set statusline+=%r
    set statusline+=%=
    set statusline+=%{strlen(&fenc)?&fenc:'none'}
    set statusline+=\ 
    set statusline+=%y
    set statusline+=\ 
    set statusline+=%l
    set statusline+=:
    set statusline+=%c
    set statusline+=\ 
    set statusline+=%L
    set statusline+=\ 
    set statusline+=%P
endfunction
call SetStatusLine()

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').")"
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
  autocmd VimResized * call SetStatusLine()
augroup END
]]
