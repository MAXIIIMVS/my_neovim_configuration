vim.g.is_transparent = false
vim.g.termdebug_running = false
vim.o.cursorline = not vim.g.is_transparent
vim.o.cursorlineopt = vim.g.is_transparent and "number" or "number,line"

require("user")

vim.o.secure = true
vim.cmd.colorscheme("catppuccin")
