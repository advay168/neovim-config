require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
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
      set_jumps = true, -- whether to set jumps in the jumplist
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
  },
  nt_cpp_tools = {
    enable = true,
    preview = {
      quit = 'q',
      accept = '<tab>'
    },
    header_extension = 'h',
    source_extension = 'cxx',
    custom_define_class_function_commands = { -- optional
      TSCppImplWrite = {
        output_handle = require 'nvim-treesitter.nt-cpp-tools.output_handlers'.get_add_to_cpp()
      }
    }
  }
}

require 'treesitter-context'.setup()


require 'nvim-treesitter.configs'.init() -- Hack until ts-cpp updates
nmap("<leader>df", ":TSCppDefineClassFunc<cr>")
xmap("<leader>df", ":TSCppDefineClassFunc<cr>")
