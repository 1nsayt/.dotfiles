local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        -- git
        {"lewis6991/gitsigns.nvim"},
        "tpope/vim-fugitive",
        -- telescope
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        -- LSP and cmp
        "onsails/lspkind-nvim",
--        "nvim-lua/lsp_extensions.nvim",
        {
            "pmizio/typescript-tools.nvim",
            dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
            opts = {}
        },
        {
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup {
                    icons = false
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end
        },
        {
            "VonHeikemen/lsp-zero.nvim",
            lazy = true,
            branch = "v3.x",
            config = false,
            init = function()
                -- Disable automatic setup, we are doing it manually
                vim.g.lsp_zero_extend_cmp = 0
                vim.g.lsp_zero_extend_lspconfig = 0
            end,
            dependencies = {
                {
                    "williamboman/mason.nvim",
                    lazy = false,
                    config = true
                },
                {
                    "williamboman/mason-lspconfig.nvim",
                    config = function()
                        require("mason-lspconfig").setup(
                            {
                                ensure_installed = {"eslint", "lua_ls", "cssls"}
                            }
                        )
                    end
                },
                -- Autocompletion
                {
                    "hrsh7th/nvim-cmp",
                    event = "InsertEnter",
                    dependencies = {

                {
                    "L3MON4D3/LuaSnip",
                    -- follow latest release.
                    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                    -- install jsregexp (optional!).
                    build = "make install_jsregexp"
                }
                    },
                    config = function()
                        -- Here is where you configure the autocompletion settings.
                        local lsp_zero = require("lsp-zero")
                        lsp_zero.extend_cmp()
                    end
                },
                {"hrsh7th/cmp-buffer"},
                {"hrsh7th/cmp-path"},
                {"saadparwaiz1/cmp_luasnip"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-nvim-lua"},
                -- LSP
                {
                    "neovim/nvim-lspconfig",
                    cmd = {"LspInfo", "LspInstall", "LspStart"},
                    opts = { inlay_hints = { enabled = true } },
                    event = {"BufReadPre", "BufNewFile"},
                    dependencies = {
                        {"hrsh7th/cmp-nvim-lsp"},
                        {"williamboman/mason-lspconfig.nvim"}
                    },
                    config = function()
                        -- This is where all the LSP shenanigans will live
                        local lsp_zero = require("lsp-zero")
                        lsp_zero.extend_lspconfig()

                        lsp_zero.on_attach(
                            function(_, bufnr)
                                -- see :help lsp-zero-keybindings
                                -- to learn the available actions
                                lsp_zero.default_keymaps({buffer = bufnr})
                            end
                        )

                        require("mason-lspconfig").setup(
                            {
                                ensure_installed = {
                                    "gopls",
                                },
                                handlers = {
                                    lsp_zero.default_setup,
                                    lua_ls = function()
                                        -- (Optional) Configure lua language server for neovim
                                        local lua_opts = lsp_zero.nvim_lua_ls()
                                        require("lspconfig").lua_ls.setup(lua_opts)
                                    end
                                }
                            }
                        )
                    end
                },
                -- Snippets
                {"rafamadriz/friendly-snippets"},
                {
                  "OlegGulevskyy/better-ts-errors.nvim",
                  dependencies = { "MunifTanjim/nui.nvim" },
                  config = {
                    keymaps = {
                      toggle = '<leader>dd', -- default '<leader>dd'
                      go_to_definition = '<leader>dx' -- default '<leader>dx'
                    }
                  }
                },
            }
        },
        {
            "nvimdev/lspsaga.nvim",
            config = function()
                require("lspsaga").setup(
                    {
                        ui = {
                            code_action = ""
                        }
                    }
                )
            end,
            dependencies = {
                {"nvim-tree/nvim-web-devicons"},
                --Please make sure you install markdown and markdown_inline parser
                {"nvim-treesitter/nvim-treesitter"}
            }
        },
        "simrat39/symbols-outline.nvim",
        --fold/unfold
        {"kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async"},
        -- org
        --    use {
        --        "nvim-neorg/neorg",
        --        build = ":Neorg sync-parsers", -- This is the important bit!
        --        dependencies = "nvim-lua/plenary.nvim"
        --    }
        -- markdown
        {"iamcco/markdown-preview.nvim"},
        --ThePrimeagen's plugins
        "ThePrimeagen/git-worktree.nvim",
        "ThePrimeagen/harpoon",
        "ThePrimeagen/refactoring.nvim",
        "mbbill/undotree",
        -- Colorscheme section
        "folke/tokyonight.nvim",
        {"catppuccin/nvim", as = "catppuccin"},
        {"rose-pine/neovim", as = "rose-pine"},
        "nvim-tree/nvim-web-devicons",
        {"nvim-lualine/lualine.nvim"},
        -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            dependencies = {
                "nvim-treesitter/nvim-treesitter-textobjects"
            }
        },
        "nvim-treesitter/playground",
        "romgrk/nvim-treesitter-context",
        -- debug
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    }
)

