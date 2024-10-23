vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Escape" })
vim.api.nvim_set_keymap("i", "<C-l>", "<CR><ESC>O", { noremap = true, silent = true, desc = "Formatted newline" })
vim.api.nvim_set_keymap("i", "<C-h>", "<LEFT><CR><ESC>O", { noremap = true, silent = true, desc = "Formatted newline" })
vim.api.nvim_set_keymap("x", "<Leader>c", [["+y]], { noremap = true, silent = true, desc = "Clipboard copy" })
vim.api.nvim_set_keymap("n", "<Leader>v", [["+p]], { noremap = true, silent = true, desc = "Clipboard paste" })


vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-6>", "<C-^>", { noremap = true, silent = true, desc = "Alternate file" })
vim.api.nvim_set_keymap("n", "<esc>", ":noh<return><esc>", { noremap = true, silent = true, desc = "Escape" })

vim.keymap.set({ "n", "t" }, "<C-h>", "<Cmd>wincmd h<CR>", { noremap = true, silent = true, desc = "Left window" })
vim.keymap.set({ "n", "t" }, "<C-j>", "<Cmd>wincmd j<CR>", { noremap = true, silent = true, desc = "Bottom window" })
vim.keymap.set({ "n", "t" }, "<C-k>", "<Cmd>wincmd k<CR>", { noremap = true, silent = true, desc = "Above window" })
vim.keymap.set({ "n", "t" }, "<C-l>", "<Cmd>wincmd l<CR>", { noremap = true, silent = true, desc = "Right window" })

vim.api.nvim_set_keymap("n", "<C-q>", "<cmd>exe 'edit' stdpath('config').'/init.lua'<CR>:cd %:h<CR>",
  { noremap = true, silent = true, desc = "Edit config" })

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Terminal escape" })
vim.api.nvim_set_keymap("o", "ie", ":<c-u>normal! ggVG<cr>",
  { noremap = true, silent = true, desc = "buffer text object" })
vim.api.nvim_set_keymap("v", "ie", "<esc>ggVG", { noremap = true, silent = true, desc = "buffer text object" })

vim.keymap.set('n', 'q', function()
  if vim.api.nvim_win_get_config(0).relative ~= "" then
    return "<C-W>c"
  else
    return "q"
  end
end, { noremap = true, silent = true, expr = true, desc = "Close floating window" })

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

-- Neovide specific
if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end, { noremap = true, silent = true, desc = "Increase font" })
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end, { noremap = true, silent = true, desc = "Decrease font" })
end
