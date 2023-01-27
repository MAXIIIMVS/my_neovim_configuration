local lualine = require("lualine")

require("zen-mode").setup({
	on_open = function(win)
		lualine.hide()
		vim.o.statusline = " "
	end,
	on_close = function()
		lualine.hide({ unhide = true })
	end,
})
