require("insayt.set")
require("insayt.packer")
require("insayt.neogit")
require("insayt.neorg")

local augroup = vim.api.nvim_create_augroup
Insayt = augroup('Insayt', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufEnter", "BufWinEnter", "TabEnter"}, {
    group = Insayt,
    pattern = "*.rs",
    callback = function()
        require("lsp_extensions").inlay_hints{}
    end
})

autocmd({"BufWritePre"}, {
    group = Insayt,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd({"BufWritePre"}, {
    group = Insayt,
    pattern = "*.tsx,*.ts,*.jsx,*.js",
    command = "EslintFixAll",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir = "rm -r"
