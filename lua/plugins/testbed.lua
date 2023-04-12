local webdev_icons_enabled = os.getenv("wt") == "1"
return {
  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        close_command = "Bdelete! %d",
        right_close_command = "Bdelete! %d",
        diagnostics = "nvim_lsp",
      }
    },
    config = function(_, opts)
      if not webdev_icons_enabled then
        opts.options.buffer_close_icon = "x"
        opts.options.close_icon = "x"
        opts.options.left_trunc_marker = "<"
        opts.options.right_trunc_marker = ">"
        opts.options.separator_style = { '|', '|' }
      end
      require("bufferline").setup(opts)

      vim.api.nvim_set_keymap("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>", noremap_silent)

      vim.api.nvim_set_keymap("n", "<A-<>", "<cmd>BufferLineMovePrev<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A->>", "<cmd>BufferLineMoveNext<CR>", noremap_silent)

      vim.api.nvim_set_keymap("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-0>", "<cmd>BufferLineGoToBuffer -1<CR>", noremap_silent)

      vim.api.nvim_set_keymap("n", "<A-p>", "<cmd>BufferLinePick<CR>", noremap_silent)
    end
  },
  {
    "moll/vim-bbye",
    config = function()
      vim.api.nvim_set_keymap("n", "<A-q>", "<cmd>Bdelete<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-D>", "<cmd>Bdelete!<CR>", noremap_silent)
      vim.api.nvim_set_keymap("n", "<A-Q>", "<cmd>Bdelete!<CR>", noremap_silent)
    end
  },
}
