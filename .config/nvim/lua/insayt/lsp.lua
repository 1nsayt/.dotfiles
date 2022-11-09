local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
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

--- I don't know is it need or now.
local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

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

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
