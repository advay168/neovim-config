vim.diagnostic.config({ virtual_text = true, severity_sort = true })

return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    version = "*",
    opts = {},
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
      vim.keymap.set({ "n", "v" }, "<leader>ff", function()
        require("conform").format({
          lsp_fallback = true
        })
      end, { noremap = true, silent = true })
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup("Lsp keybinds", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client ~= nil)

          local bufopts = { noremap = true, silent = true, buffer = event.buf }
          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
          end, bufopts)
          vim.keymap.set("i", "<c-s>", function()
            vim.lsp.buf.signature_help({
              border = "rounded",
              min_width = 1,
              max_width = 100,
              max_height = 10,
            })
          end, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)

          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)

          vim.keymap.set("n", "grh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end,
            bufopts)

          if client:supports_method('textDocument/codeLens') then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = event.buf,
              group = vim.api.nvim_create_augroup("Codelens refresh", { clear = true }),
              callback = function()
                vim.lsp.codelens.refresh({ bufnr = event.buf })
              end
            })
            vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, bufopts)
          end

          if false then
            -- treesitter folding seems better
            if client:supports_method('textDocument/foldingRange') then
              local win = vim.api.nvim_get_current_win()
              vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
            end
          end

          -- Server specific
          if client.name == "clangd" then
            vim.keymap.set("n", "<leader>o", "<cmd>LspClangdSwitchSourceHeader<CR>")
          end
        end
      })

      vim.lsp.config("clangd", {
        cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
      })

      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
            }
          }
        },
      })

      vim.lsp.config("lua_ls", {
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
      })

      vim.lsp.enable({
        "lua_ls",
        "basedpyright",
        "clangd",
        "hls",
        "vtsls",
        "cssls",
      })
    end
  },
}
