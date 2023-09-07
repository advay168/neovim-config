vim.g.python3_host_prog = os.getenv("PYTHON3_HOST_PROG")
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.mapleader = " "
require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
-- end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins",
  {
    change_detection = {
      enabled = false
    },
    install = {
      colorscheme = { "gruvbox" }
    },
  }
)
