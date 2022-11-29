local opts = {
  lualine_c = { "coc#status" },
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
