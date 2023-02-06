local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- TODO: Исправить ошибку с обработкой методов

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

			nnoremap("<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", ({ silent = true }))
			nnoremap("<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", ({ silent = true }))
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

require("mason").setup()


