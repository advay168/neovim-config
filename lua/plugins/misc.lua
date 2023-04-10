return {
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>" }
    }
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true
  },
  --"jiangmiao/auto-pairs" ,
  --"junegunn/rainbow_parentheses.vim" ,
  --"kien/rainbow_parentheses.vim" ,
}
