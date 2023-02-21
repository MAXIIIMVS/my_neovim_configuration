local lualine = require("lualine")

require("zen-mode").setup({
	---@diagnostic disable-next-line: unused-local
	on_open = function(win)
		lualine.hide({})
		vim.o.statusline = "" -- "" is same as "%t %m"
	end,
	on_close = function()
		lualine.hide({ unhide = true })
	end,
})
