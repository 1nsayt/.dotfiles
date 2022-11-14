" TODO: Move to packer
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

call plug#begin('~/.vim/plugged')

Plug 'mbbill/undotree'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" telescope requirements ...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" git plugins
Plug 'TimUntersberger/neogit'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'sindrets/diffview.nvim'

" lsp plugins
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'
"" TODO: Need to setup asap
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
"" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'rust-lang/rust.vim'

" snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'mattn/emmet-vim'

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

let g:neoformat_try_formatprg = 1
let g:rustfmt_autosave = 1
