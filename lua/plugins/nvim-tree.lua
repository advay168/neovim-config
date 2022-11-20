vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})

--vim.g.NERDTreeQuitOnOpen=1
nmap("<leader>ne", ":NvimTreeToggle<CR>")
