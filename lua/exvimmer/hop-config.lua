local u = require('utils')
local opts = { noremap = true, silent = true }

require 'hop'.setup()

u.map('n', 'F', ':HopWordMW<CR>', opts)
u.map('n', '<space>;', ':HopChar1MW<CR>', opts)
u.map('n', '<space>/', ':HopPatternMW<CR>', opts)
u.map('n', '<space>\'', ':HopLineMW<CR>', opts)
-- u.map('n', '<space>f', ':HopChar1CurrentLine<CR>', opts)
