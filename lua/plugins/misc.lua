return {
  'tpope/vim-sleuth',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  {
    'mbbill/undotree',
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>" }
    }
  },
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = true
  },
  {
    'github/copilot.vim',
    cmd = "Cen",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = false
      vim.api.nvim_set_keymap("i", "<C-J>", "copilot#Accept('')", {noremap = true, silent = true, expr = true})
      vim.cmd [[command! Cen :let g:copilot_enabled=v:true]]
    end
  },
  --'jiangmiao/auto-pairs' ,
  --'junegunn/rainbow_parentheses.vim' ,
  --'kien/rainbow_parentheses.vim' ,
}
