return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- git
    use("TimUntersberger/neogit")
    use {"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim"}

    -- telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    -- LSP and cmp
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use({"glepnir/lspsaga.nvim", branch = "main"})
    use {"williamboman/mason.nvim"}
    use "rafamadriz/friendly-snippets"

    -- TODO: need to add alternative or find out
    -- Plug 'rust-lang/rust.vim'

    -- org
    use {"nvim-neorg/neorg", requires = "nvim-lua/plenary.nvim"}

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
