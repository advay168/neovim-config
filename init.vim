set nocompatible
let mapleader = " "
set encoding=utf-8
set fileformats=unix,dos
set number
set hidden
set ignorecase
syntax enable
set backspace=indent,eol,start

filetype plugin on

set tabstop=2
set softtabstop=2
set shiftwidth=2

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
augroup pythonFile
  autocmd FileType python nmap <leader>r :!wt -d . py "%"<CR><SPACE>
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']
augroup END

set expandtab
set autoindent smartindent
set fileformat=unix
set scrolloff=7
set mouse=a
"set clipboard+=unnamedplus
set foldlevel=100

set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set relativenumber

inoremap jk <Esc>
nmap <C-j> :exe 'edit' stdpath('config').'/init.vim' <cr>

xmap <Leader>c "+y
nmap <Leader>v "+p

if (has("termguicolors"))
  set termguicolors
endif

nnoremap <silent> <C-6> <C-^>
nnoremap <silent><esc> :noh<return><esc>

call plug#begin()

"Plug 'joshdick/onedark.vim'

Plug 'morhetz/gruvbox'

"Plug 'jiangmiao/auto-pairs'

Plug 'preservim/nerdcommenter'

Plug 'preservim/nerdtree'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'honza/vim-snippets'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'junegunn/fzf.vim'

Plug 'antoinemadec/coc-fzf'

"Plug 'junegunn/rainbow_parentheses.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'Badhi/nvim-treesitter-cpp-tools'

Plug 'tpope/vim-surround'

Plug 'derekwyatt/vim-fswitch'

"Plug 'kien/rainbow_parentheses.vim'
call plug#end()

colorscheme gruvbox

let g:airline_theme="gruvbox"

lua require 'colorizer'.setup()

nmap <silent> <Leader>oh :FSLeft<cr>
nmap <silent> <Leader>oH :FSSplitLeft<cr>
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>of :FSHere<cr>

nmap <leader>b :Buffers<cr>

nmap <leader>df :TSCppDefineClassFunc<cr>
xmap <leader>df :TSCppDefineClassFunc<cr>

let g:NERDCommentEmptyLines = 1

nmap <C-_> <plug>NERDCommenterToggle
xmap <C-_> <plug>NERDCommenterToggle


let NERDTreeQuitOnOpen=1

nmap <leader>ne :NERDTreeToggle<cr>

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

nmap <leader>ac <Plug>(coc-codelens-action)

nmap <leader>fc  <Plug>(coc-fix-current)
nmap <leader>fi :CocFix<CR>
nmap <leader>do :lopen<CR>
nmap <leader>dc :lclose<CR>
nmap <leader>dn <Plug>(coc-diagnostic-next)
nmap <leader>dp <Plug>(coc-diagnostic-prev)

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

nmap <F2> <Plug>(coc-rename)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

command! -nargs=0 Format :call CocAction('format')
nmap <C-A-f> :Format<CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <C-M-p> :Files<CR>


command! -nargs=0 SetCWDasWS let b:coc_root_patterns="."

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <silent><leader>h :call CocActionAsync("doHover")<cr>

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

lua << EOF
 require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
nt_cpp_tools = {
    enable = true,
    preview = {
        quit = 'q', -- optional keymapping for quit preview
        accept = '<tab>' -- optional keymapping for accept preview
    },
    header_extension = 'h', -- optional
    source_extension = 'cxx', -- optional
    custom_define_class_function_commands = { -- optional
        TSCppImplWrite = {
            output_handle = require'nvim-treesitter.nt-cpp-tools.output_handlers'.get_add_to_cpp()
        }
        --[[
        <your impl function custom command name> = {
            output_handle = function (str, context)
                -- string contains the class implementation
                -- do whatever you want to do with it
            end
        }
        ]]
    }
}
}
EOF

let g:airline#extensions#tabline#enabled = 1

function MirrorNerdTreeIfOneWindow()
  if winnr("$") < 2
  NERDTreeMirror
  " hack to move the focus from the NERDTree to the main window
  wincmd p
  wincmd l
  endif
endfunction

autocmd TabEnter * silent exe MirrorNerdTreeIfOneWindow()
