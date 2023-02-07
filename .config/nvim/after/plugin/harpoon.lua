local silent = { silent = true }

-- These functions are stored in harpoon.  A plugn that I am developing
vim.keymap.set("n","<leader>a", function() require("harpoon.mark").add_file() end, silent)
vim.keymap.set("n","<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent)

vim.keymap.set("n","<C-h>", function() require("harpoon.ui").nav_file(1) end, silent)
vim.keymap.set("n","<C-t>", function() require("harpoon.ui").nav_file(2) end, silent)
vim.keymap.set("n","<C-n>", function() require("harpoon.ui").nav_file(3) end, silent)
vim.keymap.set("n","<C-s>", function() require("harpoon.ui").nav_file(4) end, silent)
