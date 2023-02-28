vim.g.loaded_python3_provider = 1 -- Hack to speedup opening python files. Tries to load python provider even though no plugin uses it
vim.g.mapleader = " "
require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--[[
if not vim.loop.fs_stat(lazypath) then
vim.fn.system({
"git",
"clone",
"--filter=blob:none",
"https://github.com/folke/lazy.nvim.git",
"--branch=stable", -- latest stable release
lazypath,
})
end
]]
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
