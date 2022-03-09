local o = vim.o

require('plugins')
require('mappings')
require('settings')

-- NOTE: put this at the end
o.secure = true -- XXX: security risk; don't switch this off
