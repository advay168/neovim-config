return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
    },
    {
      'L3MON4D3/LuaSnip',
      -- enabled = false,
      version = 'v2.*',
      dependencies = {
        {
          "honza/vim-snippets",
        },
      },
      config = function()
        local luasnip = require("luasnip")
        luasnip.config.set_config({
          store_selection_keys = "<c-s>",
        })
        require("luasnip.loaders.from_snipmate").lazy_load()
      end
    },
  },

  -- use a release tag to download pre-built binaries
  -- version = 'v0.*',
  build = 'cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
      ['<C-space>'] = { 'show'},
      ["<C-j>"] = {
        "snippet_forward",
        "fallback"
      },
      ["<C-k>"] = {
        "snippet_backward",
        "fallback"
      },
      ["<Tab>"] = {
        "select_next",
        "fallback"
      },
      ["<S-Tab>"] = {
        "select_prev",
        "fallback"
      },
    },

    completion = {
      list = {
        selection = { preselect = false, auto_insert = true},
      },
      menu = {
        draw = {
          -- columns = { { 'label', 'label_description', gap = 1 } },
          columns = { { "label", "label_description", gap = 1 }, { "kind", gap = 1 } },

        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = 'rounded',
          scrollbar = false,
          direction_priority = {
            menu_north = { 'e', 'w', 'n', 's' },
            menu_south = { 'e', 'w' },
          },
        },
      },
    },

    signature = {
      enabled = true,
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    snippets = {
      preset = "luasnip",
      -- expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      -- active = function(filter)
      --   if filter and filter.direction then
      --     return require('luasnip').jumpable(filter.direction)
      --   end
      --   return require('luasnip').in_snippet()
      -- end,
      -- jump = function(direction) require('luasnip').jump(direction) end,
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      cmdline = {},
    },
  },
  opts_extend = { "sources.default" }
}
