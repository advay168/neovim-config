return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "CursorHold",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("treesitter-context").setup ({
        max_lines = 10,          -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 15,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        multiline_threshold = 5, -- Maximum number of lines to show for a single context
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]]"] = "@function.outer",
            ["]m"] = "@class.outer",
          },
          goto_next_end = {
            ["]["] = "@function.outer",
            ["]M"] = "@class.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[m"] = "@class.outer",
          },
          goto_previous_end = {
            ["[]"] = "@function.outer",
            ["[M"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    "Badhi/nvim-treesitter-cpp-tools",
    ft = { "cpp", "cxx", "h", "hpp" },
    dependencies = { "nvim-treesitter" },
    config = function()
      require("nt-cpp-tools").setup {
        preview = {
          quit = "q",
          accept = "<tab>"
        },
        header_extension = "h",
        source_extension = "cxx",
        custom_define_class_function_commands = { -- optional
          TSCppImplWrite = {
            output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp()
          }
        }
      }

      vim.api.nvim_set_keymap("n", "<leader>df", "<cmd>TSCppDefineClassFunc<cr>",
        { noremap = true, silent = true, desc = "Define CPP class function" })
      vim.api.nvim_set_keymap("x", "<leader>df", "<cmd>TSCppDefineClassFunc<cr>",
        { noremap = true, silent = true, desc = "Define CPP class function" })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSInstallSync all | TSUpdateSync",
    opts = {
      highlight = {
        enable = true,
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
}
