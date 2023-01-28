set nocompatible
let mapleader = " "

augroup pythonFile
  autocmd FileType python nmap <leader>r :!wt -d . py "%"<CR><SPACE>
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']
augroup END

if (has("termguicolors"))
  set termguicolors
endif

call plug#begin()
Plug 'lewis6991/impatient.nvim'
Plug 'nathom/filetype.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'

"Plug 'morhetz/gruvbox'
Plug 'ellisonleao/gruvbox.nvim'
"Plug 'norcalli/nvim-colorizer.lua'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'commit': 'e2ee8fd7259389deaa898d1216fdc6846a26c627'}
Plug 'Badhi/nvim-treesitter-cpp-tools'

Plug 'tpope/vim-surround'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-lualine/lualine.nvim'
"Plug 'tjdevries/express_line.nvim'
"Plug 'feline-nvim/feline.nvim'
"Plug 'glepnir/galaxyline.nvim'

"Plug 'jiangmiao/auto-pairs'
"Plug 'junegunn/rainbow_parentheses.vim'
"Plug 'kien/rainbow_parentheses.vim'
Plug 'preservim/nerdcommenter'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'honza/vim-snippets'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'folke/neodev.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip'

Plug 'derekwyatt/vim-fswitch'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'

Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'j-hui/fidget.nvim'

Plug 'tommcdo/vim-exchange'
Plug 'mbbill/undotree'

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'dstein64/vim-startuptime' 

"Plug 'github/copilot.vim'

call plug#end()

lua require("impatient")

colorscheme gruvbox

lua require("init")
" ./lua/init.lua
