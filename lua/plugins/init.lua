return {
  {
    "nathom/filetype.nvim",
    enabled = false, -- Wait for plugin to update to new nvim version to resolve errors
  },
  "nvim-lua/plenary.nvim",
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        dim_inactive = true,
      })
      vim.cmd [[colorscheme gruvbox]]
    end,
    priority = 1000
  },

}
