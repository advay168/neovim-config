_G.pprint = function (x)
  print(vim.inspect(x))
end

_G.webdev_icons_enabled = os.getenv("wt") == "1"
require("options")
require("keymaps")
require("plugins")
