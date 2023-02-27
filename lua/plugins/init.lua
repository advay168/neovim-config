return {
  'nathom/filetype.nvim',
  'nvim-lua/plenary.nvim',
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require("gruvbox").setup({
        italic = false,
        dim_inactive = true,
      })
      vim.cmd [[colorscheme gruvbox]]
    end,
    priority = 1000
  },

}
