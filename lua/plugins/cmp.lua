return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      -- "zbirenbaum/copilot-cmp",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "honza/vim-snippets" },
        config = function()
          local luasnip = require("luasnip")
          luasnip.config.set_config({
            store_selection_keys = "<c-s>",
          })
          require("luasnip.loaders.from_snipmate").lazy_load()
          -- Remove tabpoints on leaving snippet
          vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = "*",
            callback = function()
              if ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
                  and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
                  and not luasnip.session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end
          })
        end
      },
    },
    config = function()
      vim.cmd [[set completeopt=menu,menuone,noselect]]

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end


      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        enabled = function()
          if vim.bo.buftype == "prompt" then
            return false
          end
          -- disable completion in comments
          local context = require("cmp.config.context")
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
          end
        end,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        experimental = {
          ghost_text = true,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
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
          ["<C-b>"] = cmp.mapping.scroll_docs( -4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          -- ["<C-m>"] = cmp.mapping.confirm({
          --   select = true,
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   config = {
          --     sources = {
          --       { name = "copilot" },
          --     }
          --   }
          -- }),
        }),
        sources = cmp.config.sources(
          {
            -- { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "nvim_lsp_signature_help" },
            { name = "path" },
          },
          {
            { name = "buffer" }
          }
        ),
        -- sorting = {
        --   priority_weight = 2,
        --   comparators = {
        --     require("copilot_cmp.comparators").prioritize,
        --
        --     -- Below is the default comparitor list and order for nvim-cmp
        --     cmp.config.compare.offset,
        --     -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        --     cmp.config.compare.exact,
        --     cmp.config.compare.score,
        --     cmp.config.compare.recently_used,
        --     cmp.config.compare.locality,
        --     cmp.config.compare.kind,
        --     cmp.config.compare.sort_text,
        --     cmp.config.compare.length,
        --     cmp.config.compare.order,
        --   },
        -- }
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" },
        }, {
          { name = "buffer" },
        })
      })

      cmp.setup.cmdline({ "/", "?" }, {
        view = {
          entries = { name = "custom", selection_order = "near_cursor" }
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline(":", {
        view = {
          entries = { name = "custom", selection_order = "near_cursor" }
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end
  },
}
