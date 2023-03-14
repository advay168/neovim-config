return {
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
      'folke/neoconf.nvim',
      "simrat39/rust-tools.nvim",
    },
    config = function()
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

      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(client, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            on_attach(client, bufnr)
          end,
        }
      })

      function _G.web()
        require 'lspconfig'.tsserver.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        require 'lspconfig'.emmet_ls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        require 'lspconfig'.cssls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        vim.cmd.LspStart()
      end
    end
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'neovim/nvim-lspconfig'
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.prettierd,
        }
      })
    end
  },
}
