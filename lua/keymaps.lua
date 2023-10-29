vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Escape" })
vim.api.nvim_set_keymap("x", "<Leader>c", [["+y]], { noremap = true, silent = true, desc = "Clipboard copy" })
vim.api.nvim_set_keymap("n", "<Leader>v", [["+p]], { noremap = true, silent = true, desc = "Clipboard paste" })

vim.api.nvim_set_keymap("n", "<C-6>", "<C-^>", { noremap = true, silent = true, desc = "Alternate file" })
vim.api.nvim_set_keymap("n", "<esc>", ":noh<return><esc>", { noremap = true, silent = true, desc = "Escape" })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Left window" })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Bottom window" })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Above window" })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Right window" })

vim.api.nvim_set_keymap("n", "<C-q>", "<cmd>exe 'edit' stdpath('config').'/init.lua'<CR>:cd %:h<CR>",
  { noremap = true, silent = true, desc = "Edit config" })

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Terminal escape" })

vim.cmd.cabbrev("W", "w")
vim.cmd.cabbrev("Wq", "wq")
vim.cmd.cabbrev("Q", "q")
vim.cmd.cabbrev("Qa", "qa")
vim.cmd.cabbrev("QA", "qa")

-- TODO Check if it works
vim.cmd [[
function! JumpToNextBufferInJumplist(dir) " 1=forward, -1=backward
    let jl = getjumplist() | let jumplist = jl[0] | let curjump = jl[1]
    let jumpcmdstr = a:dir > 0 ? '<C-O>' : '<C-I>'
    let jumpcmdchr = a:dir > 0 ? '' : '^	'    " <C-I> or <C-O>
    let searchrange = a:dir > 0 ? range(curjump+1,len(jumplist))
                              \ : range(curjump-1,0,-1)
    for i in searchrange
        if jumplist[i]["bufnr"] != bufnr('%')
            let n = (i - curjump) * a:dir
            echo "Executing ".jumpcmdstr." ".n." times."
            execute "silent normal! ".n.jumpcmdchr
            break
        endif
    endfor
endfunction
nnoremap <leader><C-O> :call JumpToNextBufferInJumplist(-1)<CR>
nnoremap <leader><C-I> :call JumpToNextBufferInJumplist( 1)<CR>
]]
