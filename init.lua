local o = vim.o

require('plugins')
require('mappings')
require('settings')

-- NOTE: put this at the end
o.secure = true
-- WARNING: 👆 security risk; don't switch this off

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd [[colorscheme catppuccin]]
