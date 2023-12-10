local cmp = require("cmp")
local lspkind = require("lspkind")
local lsp = require("lsp-zero")
local cmp_action = lsp.cmp_action()
local cmp_format = lsp.cmp_format()
require('luasnip.loaders.from_vscode').lazy_load()

lsp.preset("recommended")

lsp.on_attach(function()
    local keymap = vim.keymap.set

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like "open vsplit",
    -- you can use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

    -- Code action
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

    -- Rename all occurrences of the hovered word for the entire file
    keymap("n", "<leader>gr", "<cmd>Lspsaga rename<CR>")

    -- Rename all occurrences of the hovered word for the selected files
    keymap("n", "<leader>gR", "<cmd>Lspsaga rename ++project<CR>")

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

    -- Go to definition
    keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

    -- Go to type definition
    keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")


    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- Show buffer diagnostics
    keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    -- Show workspace diagnostics
    keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

    -- Show cursor diagnostics
    keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- Diagnostic jump with filters such as only jumping to an error
    keymap("n", "[E", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    keymap("n", "]E", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)

    -- Toggle outline
    keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    -- Pressing the key twice will enter the hover window
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- close the hover window. If you want to jump to the hover window
    -- you should use the wincmd command "<C-w>w"
    keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

    -- Call hierarchy
    keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

    -- Floating terminal
    keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
end)


local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
    sign_icons = {}
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


local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    luasnip = "[LuaSnip]",
    path = "[Path]",
}

cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  snippet = {
      expand = function(args)
          -- For `luasnip` user.
          require('luasnip').lsp_expand(args.body)
      end,
  },
  mapping = cmp_mappings,
  sources = {
      { name = "nvim_lsp" },

      { name = "luasnip" },

      { name = "buffer" },

--    { name = "neorg" },
  },
  formatting = {
        format = lspkind.cmp_format({
            with_text = true, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...',

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                vim_item.menu = source_mapping[entry.source.name]

                vim_item.dup = source_mapping[entry.source.name] or 0

                return vim_item
            end
        })
  },
})

--lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
