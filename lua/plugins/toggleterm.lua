return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = { "<leader>tf", "<leader>th", "<leader>tv" },
  config = function()
    require("toggleterm").setup {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      insert_mappings = false,
      direction = "float",
    }

    vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",
      { noremap = true, silent = true, desc = "Floating terminal" })
    vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>",
      { noremap = true, silent = true, desc = "Horizontal terminal" })
    vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",
      { noremap = true, silent = true, desc = "Vertical terminal" })
  end
}
