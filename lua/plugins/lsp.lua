vim.diagnostic.config({ virtual_text = true, severity_sort = true })

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
  },
  {
    "j-hui/fidget.nvim",
    version = "*",
    config = true,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" },
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
          markdown = { "injected" },
          typst = { "typstyle" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<space>ff", function()
        require("conform").format({
          lsp_fallback = true
        })
      end, { noremap = true, silent = true })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      require("neodev").setup()

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
        vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references<CR>", bufopts)
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, bufopts)
        vim.keymap.set("i", "<c-s>", function()
          vim.lsp.buf.signature_help({
            border = "rounded",
            min_width = 1,
            max_width = 100,
            max_height = 10,
          })
        end, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)

        vim.keymap.set("n", "<leader>gh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
          bufopts)

        if false then
          -- treesitter folding seems better
          if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
          end
        end

        -- FIXME
        if client.server_capabilities.codeLensProvider then
          vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
          vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, bufopts)
        end
      end

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      require("lspconfig").clangd.setup {
        cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.keymap.set("n", "<leader>o", "<cmd>ClangdSwitchSourceHeader<CR>")
        end,
        capabilities = capabilities,
      }

      require("lspconfig").hls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      require("lspconfig").basedpyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
            }
          }
        },
      }

      require("lspconfig").jdtls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      require("lspconfig").lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      }

      -- Prime rust tools from here to access capabilities
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Initialise rust tools to avoid eager loading dap",
        pattern = "rust",
        group = vim.api.nvim_create_augroup("RTools", { clear = true }),
        callback = function()
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
              capabilities = capabilities,
            },
          })
          vim.cmd.LspStart()
          return true
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Lazy load web lsps for performance",
        pattern = "html,css,scss,typescript,javascript,typescriptreact,javascriptreact",
        group = vim.api.nvim_create_augroup("WebLsps", { clear = true }),
        callback = function() web() end,
      })


      function _G.web()
        require("lspconfig").emmet_language_server.setup {
          filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less",
            "pug", "sass", "scss", "svelte", "typescriptreact", "vue" },
          on_attach = on_attach,
          capabilities = capabilities,
        }

        require("lspconfig").vtsls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        require("lspconfig").cssls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        vim.cmd.LspStart()
      end
    end
  },
}
