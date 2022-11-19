local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- TODO: Исправить ошибку с обработкой методов
local lspsaga = require("lspsaga")
lspsaga.init_lsp_saga()

local Remap = require("insayt.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
	return vim.tbl_deep_extend("force", {
		on_attach = function()
			nnoremap("gd", "<cmd>Lspsaga peek_definition<CR>", ({ silent = true }))
			nnoremap("K",  "<cmd>Lspsaga hover_doc<CR>", ({ silent = true }))
			nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
	     	nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
			nnoremap("]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", ({ silent = true }))
			nnoremap("[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", ({ silent = true }))
             -- TODO: NEED TO FIX
		--	nnoremap("]D", "<cmd>Lspsaga goto_prev<CR>", ({ severity = vim.diagnostic.severity.ERROR }))
		--	nnoremap("[D", "<cmd>Lspsaga goto_next<CR>", ({ severity = vim.diagnostic.severity.ERROR }))
			nnoremap("<leader>vca", "<cmd>Lspsaga code_action<CR>", ({ silent = true }))
	        nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
                filter = function(code_action)
                    if not code_action or not code_action.data then
                        return false
                    end

                    local data = code_action.data.id
                    return string.sub(data, #data - 1, #data) == ":0"
                end,
                apply = true
            }) end)
			nnoremap("<leader>vrr", "<cmd>Lspsaga lsp_finder<CR>", ({ silent = true }))
			nnoremap("<leader>vrn", "<cmd>Lspsaga rename<CR>", ({ silent = true }))
			nnoremap("<leader>vsd", "<cmd>Lspsaga show_line_diagnostics<CR>", ({ silent = true }))
			nnoremap("<leader>vsd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", ({ silent = true }))

            nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
		end,
	}, _config or {})
end

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}

--require("lspkind").init({
  --  with_text = true,
--})

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `luasnip` user.
            require('luasnip').lsp_expand(args.body)
		end,
	},

	mapping = {
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
	  },

    formatting = {
            format = lspkind.cmp_format({
            with_text = true, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
              vim_item.menu = source_mapping[entry.source.name]
              return vim_item
            end
    })
    },

	sources = {
		{ name = "nvim_lsp" },

		{ name = "luasnip" },

		{ name = "buffer" },

        { name = "neorg" },
	},
})

nvim_lsp.tsserver.setup(config())

nvim_lsp.cssls.setup(config())

nvim_lsp.rust_analyzer.setup(config({
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
	--[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}))

nvim_lsp.eslint.setup(config({
     handlers = {
         --- Just hack.This prevent issues with const in insert mode.
         ['window/showMessageRequest'] = function(_, result, params) return result end
   }
  }
 )
)

require("symbols-outline").setup({
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
})

require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
	include = nil, -- Load all languages
	exclude = {},
})

--require("mason").setup({
--        ui = {
--        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
--        border = "none",
--
--        icons = {
--            -- The list icon to use for installed packages.
--            package_installed = "◍",
--            -- The list icon to use for packages that are installing, or queued for installation.
--            package_pending = "◍",
--            -- The list icon to use for packages that are not installed.
--            package_uninstalled = "◍",
--        },
--
--        keymaps = {
--            -- Keymap to expand a package
--            toggle_package_expand = "<CR>",
--            -- Keymap to install the package under the current cursor position
--            install_package = "i",
--            -- Keymap to reinstall/update the package under the current cursor position
--            update_package = "u",
--            -- Keymap to check for new version for the package under the current cursor position
--            check_package_version = "c",
--            -- Keymap to update all installed packages
--            update_all_packages = "U",
--            -- Keymap to check which installed packages are outdated
--            check_outdated_packages = "C",
--            -- Keymap to uninstall a package
--            uninstall_package = "X",
--            -- Keymap to cancel a package installation
--            cancel_installation = "<C-c>",
--            -- Keymap to apply language filter
--            apply_language_filter = "<C-f>",
--        },
--    },
--
--    -- The directory in which to install packages.
--    install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },
--
--    pip = {
--        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
--        -- and is not recommended.
--        --
--        -- Example: { "--proxy", "https://proxyserver" }
--        install_args = {},
--    },
--
--    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
--    -- debugging issues with package installations.
--    log_level = vim.log.levels.INFO,
--
--    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
--    -- packages that are requested to be installed will be put in a queue.
--    max_concurrent_installers = 4,
--
--    github = {
--        -- The template URL to use when downloading assets from GitHub.
--        -- The placeholders are the following (in order):
--        -- 1. The repository (e.g. "rust-lang/rust-analyzer")
--        -- 2. The release version (e.g. "v0.3.0")
--        -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
--        download_url_template = "https://github.com/%s/releases/download/%s/%s",
--    },
--})


