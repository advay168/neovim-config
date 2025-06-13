return {
  --[[ {
    "norcalli/nvim-colorizer.lua",
    config = function ()
      require("colorizer").setup()
    end
  }, ]]
  {
    "iamcco/markdown-preview.nvim",
    build = ":call mkdp#util#install()",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_close = 0
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")
    end
  },
  {
    "lervag/vimtex",
    enabled = false,
    config = function()
      vim.g.vimtex_compiler_progname = 'nvr'
      vim.g.vimtex_view_method = 'sioyek'
    end
  },
  {
    "windwp/nvim-autopairs",
    enabled = false,
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({
        enable_moveright = false,
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  }
}
