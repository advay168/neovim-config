return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  enabled = false,
  config = function()

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

    require('ufo').setup({
      close_fold_kinds_for_ft = {
        default = {
          "imports",
          -- "comment",
        },
      },
    })
  end
}
