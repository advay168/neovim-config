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

nnoremap("<leader>tf", ":ToggleTerm direction=float<CR>")
nnoremap("<leader>th", ":ToggleTerm direction=horizontal<CR>")
nnoremap("<leader>tv", ":ToggleTerm direction=vertical<CR>")
