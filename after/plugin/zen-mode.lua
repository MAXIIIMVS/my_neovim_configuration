local lualine = require("lualine")

require("zen-mode").setup({
	on_open = function(win)
		lualine.hide()
		vim.cmd("set statusline=%{reg_recording()}")
		vim.cmd("set statusline+=%=%{&modified?'🟢':''}")
	end,
	on_close = function()
		lualine.hide({ unhide = true })
	end,
})
