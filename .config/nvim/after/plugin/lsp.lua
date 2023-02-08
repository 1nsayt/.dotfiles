local cmp = require("cmp")
local lspkind = require("lspkind")
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'cssls',
})

lspzon_attach(function(client, bufnr)

    local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n","gd", "<cmd>Lspsaga peek_definition<CR>", ({ silent = true }))
	vim.keymap.set("n","K",  "<cmd>Lspsaga hover_doc<CR>", ({ silent = true }))
	vim.keymap.set("n","<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
	vim.keymap.set("n","<leader>vd", function() vim.diagnostic.open_float() end)
	vim.keymap.set("n","]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", ({ silent = true }))
	vim.keymap.set("n","[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", ({ silent = true }))
    --  TODO: NEED TO FIX
	--	vim.keymap.set("n","]D", "<cmd>Lspsaga goto_prev<CR>", ({ severity = vim.diagnostic.severity.ERROR }))
	--	vim.keymap.set("n","[D", "<cmd>Lspsaga goto_next<CR>", ({ severity = vim.diagnostic.severity.ERROR }))
	vim.keymap.set("n","<leader>vca", "<cmd>Lspsaga code_action<CR>", ({ silent = true }))
	vim.keymap.set("n","<leader>vco", function() vim.lsp.buf.code_action({
        filter = function(code_action)
            if not code_action or not code_action.data then
                return false
            end

            local data = code_action.data.id
            return string.sub(data, #data - 1, #data) == ":0"
        end,
        apply = true
    }) end)
	vim.keymap.set("n","<leader>vrr", "<cmd>Lspsaga lsp_finder<CR>", ({ silent = true }))
	vim.keymap.set("n","<leader>vrn", "<cmd>Lspsaga rename<CR>", ({ silent = true }))
	vim.keymap.set("n","<leader>vsd", "<cmd>Lspsaga show_line_diagnostics<CR>", ({ silent = true }))
	vim.keymap.set("n","<leader>vsd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", ({ silent = true }))

    vim.keymap.set("n","<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)

	vim.keymap.set("n","<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", ({ silent = true }))
	vim.keymap.set("n","<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", ({ silent = true }))
end)

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
  sign_icons = { }
})

lsp.setup_nvim_cmp({
	snippet = {
		expand = function(args)
			-- For `luasnip` user.
            require('luasnip').lsp_expand(args.body)
		end,
	},

	mapping = cmp_mappings,

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

lsp.setup()


