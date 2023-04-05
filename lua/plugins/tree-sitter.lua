return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { "nvim-treesitter" },
    config = true
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { "nvim-treesitter" },
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      }
    },
    config = function(_, opts)
      require 'nvim-treesitter.configs'.setup(opts)
    end
  },
  {
    'Badhi/nvim-treesitter-cpp-tools',
    ft = { "cpp", "cxx", "h", "hpp" },
    dependencies = { "nvim-treesitter" },
    config = function()
      require 'nt-cpp-tools'.setup {
        preview = {
          quit = 'q',
          accept = '<tab>'
        },
        header_extension = 'h',
        source_extension = 'cxx',
        custom_define_class_function_commands = { -- optional
          TSCppImplWrite = {
            output_handle = require 'nt-cpp-tools.output_handlers'.get_add_to_cpp()
          }
        }
      }

      vim.api.nvim_set_keymap("n", "<leader>df", "<cmd>TSCppDefineClassFunc<cr>", noremap_silent)
      vim.api.nvim_set_keymap("x", "<leader>df", "<cmd>TSCppDefineClassFunc<cr>", noremap_silent)
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdateSync',
    opts = {
      --ensure_installed = "all",
      highlight = {
        enable = true,
      }
    },
    config = function(_, opts)
      require 'nvim-treesitter.configs'.setup(opts)
    end
  },
}
