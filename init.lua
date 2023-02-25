vim.g.mapleader = " "
require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--[[
if not vim.loop.fs_stat(lazypath) then
vim.fn.system({
"git",
"clone",
"--filter=blob:none",
"https://github.com/folke/lazy.nvim.git",
"--branch=stable", -- latest stable release
lazypath,
})
end
]]
vim.opt.rtp:prepend(lazypath)
_G.webdev_icons_enabled = os.getenv("wt") == "1"
require("lazy").setup(
  {
    'nathom/filetype.nvim',
    'nvim-lua/plenary.nvim',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    'lukas-reineke/indent-blankline.nvim',
    'dstein64/nvim-scrollview',

    {
      'ellisonleao/gruvbox.nvim',
      config = function(_, _)
        require("gruvbox").setup({
          italic = false,
          dim_inactive = true,
        })
        vim.cmd [[colorscheme gruvbox]]
      end,
      priority = 1000
    },

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
      config = function(_, _)
        require 'nvim-treesitter.configs'.setup {
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

    {
      'mbbill/undotree',
      keys = {
        { "<leader>u", "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>" }
      }
    },
    {
      'nvim-tree/nvim-tree.lua',
      enabled = false,
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function(_, _)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup({
          sort_by = "case_sensitive",
          view = {
            adaptive_size = true,
            mappings = {
              list = {
                { key = "u", action = "dir_up" },
              },
            },
          },
          renderer = {
            group_empty = true,
            icons = {
              show = {
                file = webdev_icons_enabled,
                folder = webdev_icons_enabled,
                folder_arrow = webdev_icons_enabled,
                git = webdev_icons_enabled,
              },
            },
          },
          actions = {
            open_file = {
              quit_on_open = true,
            }
          },
          --update_focused_file = {
          --enable = true,
          --},
          filters = {
            dotfiles = true,
          },
          filesystem_watchers = {
            enable = false,
          },
        })

        local function open_nvim_tree(data)
          local is_a_directory = vim.fn.isdirectory(data.file) == 1

          if is_a_directory then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
            return
          end

          --local is_real_file = vim.fn.filereadable(data.file) == 1
          --local is_no_name_file = data.file == "" and vim.bo[data.buf].buftype == ""
          --if is_real_file or is_no_name_file then
          --require("nvim-tree.api").tree.toggle { focus = false, find_file = true }
          --return
          --end
        end
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

        vim.api.nvim_set_keymap("n", "<leader>ne", "<cmd>NvimTreeToggle<CR>", noremap_silent)
      end
    },
    {
      'romgrk/barbar.nvim',
      dependencies = { "nvim-web-devicons" },
      priority = 40,
      config = function(_, _)
        if (not webdev_icons_enabled) then
          require("bufferline").setup({
            icons = false,
            icon_separator_active = "|",
            icon_separator_inactive = "|",
            icon_close_tab = "x"
          })
        end

        vim.api.nvim_set_keymap("n", "<A-,>", "<cmd>BufferPrevious<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-.>", "<cmd>BufferNext<CR>", noremap_silent)

        vim.api.nvim_set_keymap("n", "<A-<>", "<cmd>BufferMovePrevious<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A->>", "<cmd>BufferMoveNext<CR>", noremap_silent)

        vim.api.nvim_set_keymap("n", "<A-1>", "<cmd>BufferGoto 1<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-2>", "<cmd>BufferGoto 2<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-3>", "<cmd>BufferGoto 3<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-4>", "<cmd>BufferGoto 4<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-5>", "<cmd>BufferGoto 5<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-6>", "<cmd>BufferGoto 6<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-7>", "<cmd>BufferGoto 7<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-8>", "<cmd>BufferGoto 8<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-9>", "<cmd>BufferGoto 9<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-0>", "<cmd>BufferLast<CR>", noremap_silent)

        vim.api.nvim_set_keymap("n", "<A-q>", "<cmd>BufferClose<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-D>", "<cmd>BufferClose!<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-Q>", "<cmd>BufferClose!<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<A-p>", "<cmd>BufferPick<CR>", noremap_silent)

        local exists = pcall(require, "nvim-tree")
        if not exists then return end
        local nvim_tree_events = require('nvim-tree.events')
        local bufferline_api = require('bufferline.api')

        local function get_tree_size()
          return require 'nvim-tree.view'.View.width
        end

        nvim_tree_events.subscribe('TreeOpen', function()
          bufferline_api.set_offset(get_tree_size())
        end)

        nvim_tree_events.subscribe('Resize', function()
          bufferline_api.set_offset(get_tree_size())
        end)

        nvim_tree_events.subscribe('TreeClose', function()
          bufferline_api.set_offset(0)
        end)
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      enabled = false,
      config = function(_, _)
        local opts = {
          options = {
            theme = "gruvbox",
          },
        }
        if (not webdev_icons_enabled) then
          opts.options.section_separators = ''
          opts.options.component_separators = ''
          opts.options.icons_enabled = false
        end

        require("lualine").setup(opts)
      end
    },
    --'jiangmiao/auto-pairs' ,
    --'junegunn/rainbow_parentheses.vim' ,
    --'kien/rainbow_parentheses.vim' ,
    {
      'preservim/nerdcommenter',
      event = "VeryLazy",
      config = function(_, _)
        vim.g.NERDCommentEmptyLines = 1
        vim.g.NERDDefaultAlign = 'left'

        vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>NERDCommenterToggle", noremap_silent)
        vim.api.nvim_set_keymap("x", "<C-_>", "<Plug>NERDCommenterToggle", noremap_silent)
      end
    },

    {
      'nvim-telescope/telescope.nvim',
      version = '0.1.1',
      dependencies = { {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      } },
      cmd = "Telescope",
      keys = { "<leader>b", "<C-p>", "<C-f>", "<leader>tt" },
      config = function(_, _)
        require('telescope').setup {
        }

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>b', builtin.buffers, { noremap = true })
        vim.keymap.set('n', '<C-p>', builtin.find_files, { noremap = true })
        vim.keymap.set('n', '<C-f>', builtin.live_grep, { noremap = true })
        vim.keymap.set('n', '<leader>tt', builtin.builtin, { noremap = true })
        require('telescope').load_extension('fzf')
      end
    },

    {
      'j-hui/fidget.nvim',
      config = true
    },

    {
      'williamboman/mason.nvim',
      config = function(_, _)
        require("mason").setup()
      end
    },

    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'folke/neodev.nvim',
        'folke/neoconf.nvim',
      },
      config = function(_, _)
        require("neodev").setup({
          library = {
            plugins = { "lazy.nvim" },
          },
        })
        require("neodev").setup()

        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        local on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", bufopts)
          vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<CR>", bufopts)
          vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<CR>", bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

          if client.server_capabilities.codeLensProvider then
            vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
            vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, bufopts)
          end
        end

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require 'lspconfig'.clangd.setup {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.keymap.set("", "<leader>o", "<cmd>ClangdSwitchSourceHeader<CR>")
          end,
          capabilities = capabilities,
        }

        require 'lspconfig'.hls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        require 'lspconfig'.pyright.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        require 'lspconfig'.lua_ls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        -- Commented out html plugins because of limited use currently
        --[[
            require 'lspconfig'.tsserver.setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }

            require 'lspconfig'.emmet_ls.setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
        --]]
      end
    },
    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'neovim/nvim-lspconfig'
      },
      ft = "py",
      config = function(_, _)
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.black,
          }
        })
      end
    },

    {
      'hrsh7th/nvim-cmp',
      lazy = true,
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'saadparwaiz1/cmp_luasnip',
        {
          "L3MON4D3/LuaSnip",
          dependencies = { "honza/vim-snippets" },
        },
      },
      config = function(_, _)
        vim.cmd [[set completeopt=menu,menuone,noselect]]

        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end


        local cmp = require('cmp')
        local luasnip = require("luasnip")
        cmp.setup({
          enabled = function()
            if vim.bo.buftype == 'prompt' then
              return false
            end
            -- disable completion in comments
            local context = require 'cmp.config.context'
            if vim.api.nvim_get_mode().mode == 'c' then
              return true
            else
              return not context.in_treesitter_capture("comment")
                  and not context.in_syntax_group("Comment")
            end
          end,
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          experimental = {
            ghost_text = true,
          },
          confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
          },
          window = {
            --completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
              else
                fallback()
              end
            end, { "i", "s" }),
            ['<C-b>'] = cmp.mapping.scroll_docs( -4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete({}),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
          }),
          sources = cmp.config.sources(
            {
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              { name = 'nvim_lsp_signature_help' },
              { name = 'path' },
            },
            {
              { name = 'buffer' }
            }
          )
        })

        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'cmp_git' },
          }, {
            { name = 'buffer' },
          })
        })

        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })

        luasnip.config.set_config({
          store_selection_keys = '<c-s>',
        })
        require("luasnip.loaders.from_snipmate").lazy_load()
      end
    },

    {
      'mfussenegger/nvim-dap',
      dependencies = {
        'mfussenegger/nvim-dap-python',
        {
          'rcarriga/nvim-dap-ui',
        },
      },
      keys = {
        { "<leader>db", function() require 'dap'.toggle_breakpoint() end },
        { "<leader>dc", function() require 'dap'.run_to_cursor() end },
        { "<F6>",       function() require 'dap'.step_into() end },
        { "<F5>",       function() require 'dap'.continue({}) end },
        { "<F4>",       function() require 'dap'.step_out() end },
        { "<F3>",       function() require 'dap'.step_over() end },
        { "<leader>dh", function() require 'dap'.pause() end },
        { "<leader>dr", function() require 'dapui'.float_element('repl', {}) end },
        { "<leader>dl", function() require 'dap'.run_last() end },
        { "<leader>dq", function() require 'dap'.close() end },
        { "<leader>dd", function() require 'dapui'.toggle({}) end },
      },
      config = function(_, _)
        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

        local dap_py = require("dap-python")
        dap_py.setup("D:/dev/nvim-dap-data/debugpy.venv/Scripts/pythonw.exe")

        local dap = require('dap')
        for _, conf in ipairs(dap.configurations.python) do
          conf.justMyCode = false
          conf.redirectOutput = true
          conf.showReturnValue = true
        end

        dap.adapters.codelldb = {
          type = 'server',
          port = "${port}",
          executable = {
            command = 'D:/dev/nvim-dap-data/codelldb/extension/adapter/codelldb.exe',
            args = { "--port", "${port}" },

            -- On windows you may have to uncomment this:
            -- detached = false,
          }
        }

        dap.configurations.cpp = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              ---@diagnostic disable-next-line: redundant-parameter, param-type-mismatch
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
          },
        }
        local dapui = require("dapui")
        dapui.setup({
          layouts = {
            {
              elements = {
                { id = "stacks",      size = 0.29 },
                { id = "scopes",      size = 0.30 },
                { id = "breakpoints", size = 0.16 },
                { id = "watches",     size = 0.25 },
              },
              size = 0.33,
              position = "right",
            },
            {
              elements = {
                { id = "repl", size = 0.45 },
                --{ id = "console", size = 0.55 },
              },
              size = 0.25,
              position = "bottom",
            },
          },
          floating = {
            max_width = 0.5, -- Floats will be treated as percentage of your screen.
            border = "rounded", -- Border style. Can be 'single', 'double' or 'rounded'
            mappings = {
              close = { "q", "<Esc>" },
            },
          }
        }
        )

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
      end

    },
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      keys = { "<leader>tf", "<leader>th", "<leader>tv" },
      config = function(_, _)
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

        vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", noremap_silent)
        vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", noremap_silent)
      end
    },

    {
      'github/copilot.vim',
      cmd = "Cen",
      config = function(_, _)
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_enabled = false
        vim.api.nvim_set_keymap("i", "<C-J>", "copilot#Accept('')", noremap_silent)
        vim.cmd [[command! Cen :let g:copilot_enabled=v:true]]
      end
    },
  },
  {
    change_detection = {
      enabled = false
    },
    install = {
      colorscheme = { "gruvbox" }
    },
  }
)
