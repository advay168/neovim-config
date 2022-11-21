require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
      },
    },
  },
  pickers = {
  },
  extensions = {
    coc = {
    },
  },
}
require('telescope').load_extension('coc')

nmap("<leader>b", ":Telescope buffers<CR>")
nnoremap("<C-p>", ":Telescope find_files<CR>")
nnoremap("<C-f>", ":Telescope live_grep<CR>")
