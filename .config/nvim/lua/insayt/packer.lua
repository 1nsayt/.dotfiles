return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- git
    use("TimUntersberger/neogit")
    use {"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim"}
    use {"lewis6991/gitsigns.nvim"}

    -- telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    -- LSP and cmp
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")


    use {
         'VonHeikemen/lsp-zero.nvim',
         branch = 'v1.x',
         requires = {
             -- LSP Support
             {'neovim/nvim-lspconfig'},
             {'williamboman/mason.nvim'},
             {'williamboman/mason-lspconfig.nvim'},

             -- Autocompletion
             {'hrsh7th/nvim-cmp'},
             {'hrsh7th/cmp-buffer'},
             {'hrsh7th/cmp-path'},
             {'saadparwaiz1/cmp_luasnip'},
             {'hrsh7th/cmp-nvim-lsp'},
             {'hrsh7th/cmp-nvim-lua'},

             -- Snippets
             {'L3MON4D3/LuaSnip'},
             {'rafamadriz/friendly-snippets'},
         }
     }

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("lspsaga").setup({})
        end,
        requires = { {"nvim-tree/nvim-web-devicons"} }
    })

    use("simrat39/symbols-outline.nvim")

    --fold/unfold
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

    -- TODO: need to add alternative or find out
    -- Plug 'rust-lang/rust.vim'

    -- org
    use {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers", -- This is the important bit!
        requires = "nvim-lua/plenary.nvim"
    }
    -- markdown
    use {'iamcco/markdown-preview.nvim'}

    --ThePrimeagen's plugins
    use("ThePrimeagen/git-worktree.nvim")
    use("ThePrimeagen/harpoon")
    use("ThePrimeagen/refactoring.nvim")

    use("mbbill/undotree")

    -- Colorscheme section
    use("folke/tokyonight.nvim")
    use({"catppuccin/nvim", as = "catppuccin"})
    use({'rose-pine/neovim', as = 'rose-pine'})

    use 'nvim-tree/nvim-web-devicons'
    use({'nvim-lualine/lualine.nvim'})

    -- treesitter
    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- debug
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

end)
