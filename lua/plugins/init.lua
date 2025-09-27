return {
  "nvim-lua/plenary.nvim",
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        -- dim_inactive = true,
        transparent_mode = true,
      })
      vim.cmd.colorscheme("gruvbox")
    end,
    priority = 1000
  },
}
