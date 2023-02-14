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
    icons = {
      show = {
        file = webdev_icons_enabled,
        folder = webdev_icons_enabled,
        folder_arrow = webdev_icons_enabled,
        git = webdev_icons_enabled,
      },
    },
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

local function open_nvim_tree(data)
  local is_a_directory = vim.fn.isdirectory(data.file) == 1

  if is_a_directory then
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
    return
  end

  --local is_real_file = vim.fn.filereadable(data.file) == 1
  --local is_no_name_file = data.file == "" and vim.bo[data.buf].buftype == ""
  --if is_real_file or is_no_name_file then
  --require("nvim-tree.api").tree.toggle { focus = false, find_file = true }
  --return
  --end
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

nmap("<leader>ne", ":NvimTreeToggle<CR>")
