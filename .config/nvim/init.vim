set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

call plug#begin('~/.vim/plugged')


Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mbbill/undotree'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" telescope requirements ...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'

" lsp plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'stevearc/aerial.nvim'

" snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'mattn/emmet-vim'

Plug 'rust-lang/rust.vim'

" prettier
Plug 'sbdchd/neoformat'

" some other stuff
Plug 'nvim-neorg/neorg'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

let g:tokyonight_style = "night"
colorscheme tokyonight

highlight Normal guibg=none

lua require('insayt')

let mapleader = " "
let g:neoformat_try_formatprg = 1
let g:rustfmt_autosave = 1

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Ex<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>sv :source $MYVIMRC<CR>

inoremap <C-c> <esc>

augroup INSAYT
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
augroup END
