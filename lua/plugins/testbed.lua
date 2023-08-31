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

      vim.api.nvim_set_keymap("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>",
        { noremap = true, silent = true, desc = "Buffer Cycle Prev" })
      vim.api.nvim_set_keymap("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>",
        { noremap = true, silent = true, desc = "Buffer Cycle Next" })

      vim.api.nvim_set_keymap("n", "<A-<>", "<cmd>BufferLineMovePrev<CR>",
        { noremap = true, silent = true, desc = "Move Buffer Prev" })
      vim.api.nvim_set_keymap("n", "<A->>", "<cmd>BufferLineMoveNext<CR>",
        { noremap = true, silent = true, desc = "Move Buffer Next" })

      vim.api.nvim_set_keymap("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 1" })
      vim.api.nvim_set_keymap("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 2" })
      vim.api.nvim_set_keymap("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 3" })
      vim.api.nvim_set_keymap("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 4" })
      vim.api.nvim_set_keymap("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 5" })
      vim.api.nvim_set_keymap("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 6" })
      vim.api.nvim_set_keymap("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 7" })
      vim.api.nvim_set_keymap("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 8" })
      vim.api.nvim_set_keymap("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>",
        { noremap = true, silent = true, desc = "Goto visible buffer 9" })
      vim.api.nvim_set_keymap("n", "<A-0>", "<cmd>BufferLineGoToBuffer -1<CR>",
        { noremap = true, silent = true, desc = "Goto visible last visible buffer" })

      vim.api.nvim_set_keymap("n", "<A-p>", "<cmd>BufferLinePick<CR>",
        { noremap = true, silent = true, desc = "Pick buffer" })
    end
  },
  {
    "moll/vim-bbye",
    keys = {
      { "<A-q>", "<cmd>Bdelete<CR>", noremap = true, silent = true, desc = "Delete buffer", mode = "n" },
      { "<A-D>", "<cmd>Bdelete!<CR>", noremap = true, silent = true, desc = "Force delete buffer", mode = "n" },
      { "<A-Q>", "<cmd>Bdelete!<CR>", noremap = true, silent = true, desc = "Force delete buffer", mode = "n" }
    }
  },
}
