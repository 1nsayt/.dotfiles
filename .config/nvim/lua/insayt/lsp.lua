local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = require("aerial").on_attach,
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

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
