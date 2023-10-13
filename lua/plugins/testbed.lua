return {
  {
    "iamcco/markdown-preview.nvim",
    build = ":call mkdp#util#install()",
    config = function()
      vim.g.mkdp_auto_close = 0
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")
      local group = vim.api.nvim_create_augroup("loadNotes", {})
      vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        group = group,
        pattern = { "*/notes/**/*.md" },
        command = "MarkdownPreview",
      })
      --[[ vim.api.nvim_create_autocmd({ "BufWipeout" }, {
        group = group,
        pattern = { "*/notes/**/*.md" },
        callback = function()
          vim.cmd "call mkdp#rpc#preview_close()"
        end
      }) ]]
    end
  },
  {
    "lervag/vimtex",
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
