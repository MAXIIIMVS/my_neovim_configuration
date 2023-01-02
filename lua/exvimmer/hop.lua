local opts = { noremap = true, silent = true }

require("hop").setup()

vim.keymap.set("n", ";w", ":HopWordMW<CR>", opts)
vim.keymap.set("n", ";c", ":HopChar1MW<CR>", opts)
vim.keymap.set("n", ";p", ":HopPatternMW<CR>", opts)
vim.keymap.set("n", ";l", ":HopLineMW<CR>", opts)
