require'hop'.setup()

local u = require('utils')
local opts = { noremap=true, silent=true }
u.map('n', '<space>;', ':HopWordMW<CR>', opts)
u.map('n', '<space>/', ':HopPatternMW<CR>', opts)
u.map('n', '<space>\'', ':HopLineMW<CR>', opts)
u.map('n', '<space>f', ':HopChar1MW<CR>', opts)

