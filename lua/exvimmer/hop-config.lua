local u = require('utils')
local opts = { noremap=true, silent=true }

require'hop'.setup()

u.map('n', '<space>;', ':HopWordMW<CR>', opts)
u.map('n', '<space>/', ':HopPatternMW<CR>', opts)
u.map('n', '<space>\'', ':HopLineMW<CR>', opts)
u.map('n', '<space>,', ':HopChar1MW<CR>', opts)
