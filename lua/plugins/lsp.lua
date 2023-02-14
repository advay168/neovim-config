require("mason").setup()
require("mason-lspconfig").setup()

require("neodev").setup({
  library = {
    plugins = { "nvim-dap-ui" },
  },
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', ":Telescope lsp_definitions<CR>", bufopts)
  vim.keymap.set('n', 'gr', ":Telescope lsp_references<CR>", bufopts)
  vim.keymap.set('n', 'gi', ":Telescope lsp_implementations<CR>", bufopts)
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
    vim.keymap.set("", "<leader>o", ":ClangdSwitchSourceHeader<CR>")
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

require 'lspconfig'.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

--require("mason-lspconfig").setup_handlers {
--function(server_name)
--require("lspconfig")[server_name].setup {
--on_attach = on_attach,
--capabilities = capabilities,
--}
--end,
--}

require("plugins.cmp")
