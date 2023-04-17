local webdev_icons_enabled = os.getenv("wt") == "1"
local oil_column = ""
if webdev_icons_enabled then
  oil_column = "icon"
end

return {
  "lukas-reineke/indent-blankline.nvim",
  "dstein64/nvim-scrollview",
  {
    "nvim-tree/nvim-web-devicons",
    cond = webdev_icons_enabled,
    lazy = true,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-web-devicons" },
    cmd = "Oil",
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("lazy").load({ plugins = { "oil.nvim" } })
        end
      end
      if not require("lazy.core.config").plugins["oil.nvim"]._.loaded then
        vim.api.nvim_create_autocmd("BufNew", {
          callback = function()
            if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
              require("lazy").load({ plugins = { "oil.nvim" } })
              return true
            end
          end,
        })
      end
    end,
    opts = {
      columns = {
        oil_column
      }
    },
    config = true
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    config = function()
      local opts = {
        options = {
          theme = "gruvbox",
        },
      }
      if (not webdev_icons_enabled) then
        opts.options.section_separators = ""
        opts.options.component_separators = ""
        opts.options.icons_enabled = false
      end

      require("lualine").setup(opts)
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    dependencies = { "nvim-web-devicons" },
    config = function()
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

      vim.api.nvim_set_keymap("n", "<leader>ne", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "" })
    end
  },
}
