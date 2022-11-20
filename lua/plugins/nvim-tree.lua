vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  --update_focused_file = {
    --enable = true,
  --},
  filters = {
    dotfiles = true,
  },
  filesystem_watchers = {
    enable = false,
  },
})

nmap("<leader>ne", ":NvimTreeToggle<CR>")
