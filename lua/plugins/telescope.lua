local function l(x)
  return "<leader>" .. x
end
return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      {
        "benfowler/telescope-luasnip.nvim"
      },
    },
    cmd = "Telescope",
    keys = { l("tt"), l("fb"), l("<leader>"), l("fg"), l("fh") },
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            n = {
              ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
            },
            i = {
              ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
          layout_strategy = "flex",
          layout_config = {
            width = function (_, cols, _)
              return math.floor(cols*0.93)
            end,
            height = function (_, _, rows)
              return math.floor(rows*0.93)
            end,
          },
          dynamic_preview_title = true,
          winblend = 10,
          borderchars = {
            --           N    E    S    W   NW   NE   SE   SW
            prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          },
        }
      }

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>tt", ":Telescope ")
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
      vim.keymap.set("n", "<leader><leader>", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("luasnip")
    end
  },
}
