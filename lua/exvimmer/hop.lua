local u = require("utils")
local opts = { noremap = true, silent = true }

require("hop").setup()

u.map("n", ";w", ":HopWordMW<CR>", opts)
u.map("n", ";c", ":HopChar1MW<CR>", opts)
u.map("n", ";p", ":HopPatternMW<CR>", opts)
u.map("n", ";l", ":HopLineMW<CR>", opts)
