-- local lualine = require("lualine")

require("zen-mode").setup({
	window = {
		width = 100,
	},
	---@diagnostic disable-next-line: unused-local
	on_open = function(win)
		-- lualine.hide({})
		-- vim.o.statusline = "" -- "" is same as "%t %m"
		vim.o.cmdheight = 1
	end,
	on_close = function()
		vim.o.cmdheight = 0
		-- lualine.hide({ unhide = true })
	end,
})
