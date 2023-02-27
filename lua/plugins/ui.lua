return {
  'lukas-reineke/indent-blankline.nvim',
  'dstein64/nvim-scrollview',
  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
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

      vim.api.nvim_set_keymap("n", "<leader>ne", "<cmd>NvimTreeToggle<CR>", noremap_silent)
    end
  },
  {
    'romgrk/barbar.nvim',
    dependencies = { "nvim-web-devicons" },
    priority = 40,
    config = function()
      if (not webdev_icons_enabled) then
        require("bufferline").setup({
          icons = false,
          icon_separator_active = "|",
          icon_separator_inactive = "|",
          icon_close_tab = "x"
        })
      end

      vim.api.nvim_set_keymap("n", "<A-,>", "<cmd>BufferPrevious<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-.>", "<cmd>BufferNext<CR>", noremap_silent)

      vim.api.nvim_set_keymap("n", "<A-<>", "<cmd>BufferMovePrevious<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A->>", "<cmd>BufferMoveNext<CR>", noremap_silent)

      vim.api.nvim_set_keymap("n", "<A-1>", "<cmd>BufferGoto 1<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-2>", "<cmd>BufferGoto 2<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-3>", "<cmd>BufferGoto 3<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-4>", "<cmd>BufferGoto 4<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-5>", "<cmd>BufferGoto 5<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-6>", "<cmd>BufferGoto 6<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-7>", "<cmd>BufferGoto 7<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-8>", "<cmd>BufferGoto 8<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-9>", "<cmd>BufferGoto 9<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-0>", "<cmd>BufferLast<CR>", noremap_silent)

      vim.api.nvim_set_keymap("n", "<A-q>", "<cmd>BufferClose<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-D>", "<cmd>BufferClose!<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-Q>", "<cmd>BufferClose!<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-p>", "<cmd>BufferPick<CR>", noremap_silent)

      local exists = pcall(require, "nvim-tree")
      if not exists then return end
      local nvim_tree_events = require('nvim-tree.events')
      local bufferline_api = require('bufferline.api')

      local function get_tree_size()
        return require 'nvim-tree.view'.View.width
      end

      nvim_tree_events.subscribe('TreeOpen', function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe('Resize', function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe('TreeClose', function()
        bufferline_api.set_offset(0)
      end)
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    config = function()
      local opts = {
        options = {
          theme = "gruvbox",
        },
      }
      if (not webdev_icons_enabled) then
        opts.options.section_separators = ''
        opts.options.component_separators = ''
        opts.options.icons_enabled = false
      end

      require("lualine").setup(opts)
    end
  },
  {
    'j-hui/fidget.nvim',
    config = true
  },
}
