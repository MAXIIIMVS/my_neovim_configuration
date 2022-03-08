local o = vim.o

require('plugins')
require('settings')
require('mappings')

-- NOTE: put this at the end
o.secure = true -- BUG: security risk; don't switch this off
