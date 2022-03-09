local o = vim.o

require('plugins')
require('mappings')
require('settings')

vim.cmd('colorscheme aurora')

-- NOTE: put this at the end
o.secure = true -- XXX: security risk; don't switch this off
