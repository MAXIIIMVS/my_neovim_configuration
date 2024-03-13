vim.g.is_transparent = false
vim.g.termdebug_running = false
vim.o.cursorlineopt = vim.g.is_transparent and "number" or "number,line"
vim.o.cursorline = not vim.g.is_transparent

require("exvimmer")

vim.o.secure = true
-- vim.cmd("silent CatppuccinCompile") -- NOTE: this will make startup slower
vim.cmd.colorscheme("catppuccin")
