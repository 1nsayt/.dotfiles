local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
vim.opt.rtp:prepend(lazypath)

--leader map

require("lazy").setup({
        -- git
        { "lewis6991/gitsigns.nvim" },
        "tpope/vim-fugitive",

        -- telescope
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",

        -- LSP and cmp
        "onsails/lspkind-nvim",
        "nvim-lua/lsp_extensions.nvim",

        {
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup {
                    icons = false,
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end
        },


        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            dependencies = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },

                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'rafamadriz/friendly-snippets' },
            }
        },

        {
            "glepnir/lspsaga.nvim",
            opt = true,
            branch = "main",
            event = "LspAttach",
            config = function()
                require("lspsaga").setup({
                    ui = {
                        code_action = "",
                    }
                })
            end,
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
                --Please make sure you install markdown and markdown_inline parser
                { "nvim-treesitter/nvim-treesitter" }
            }
        },

        "simrat39/symbols-outline.nvim",

        --fold/unfold
        { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },

        -- org
        --    use {
        --        "nvim-neorg/neorg",
        --        build = ":Neorg sync-parsers", -- This is the important bit!
        --        dependencies = "nvim-lua/plenary.nvim"
        --    }
        -- markdown
        { 'iamcco/markdown-preview.nvim' },

        --ThePrimeagen's plugins
        "ThePrimeagen/git-worktree.nvim",
        "ThePrimeagen/harpoon",
        "ThePrimeagen/refactoring.nvim",

        "mbbill/undotree",

        -- Colorscheme section
        "folke/tokyonight.nvim",
        { "catppuccin/nvim", as = "catppuccin" },
        { 'rose-pine/neovim', as = 'rose-pine' },

        'nvim-tree/nvim-web-devicons',
        { 'nvim-lualine/lualine.nvim' },

        -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            dependencies = {
              "nvim-treesitter/nvim-treesitter-textobjects",
            }
        },
        "nvim-treesitter/playground",
        "romgrk/nvim-treesitter-context",

        -- debug
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",

        "m4xshen/hardtime.nvim",
    })
