local wk = require("which-key")

wk.register({
	C = {
		name = "Color Picker",
		h = { "<cmd>silent VCoolor<CR>", "HEX color <M-c>" }, -- <M-c>
		H = { "<cmd>silent VCoolIns h<CR>", "HSL color <M-v>" }, -- <M-v>
		r = { "<cmd>silent VCoolIns r <CR>", "RGB color <M-r>" }, -- <M-r>
		-- R = { "<cmd>silent bufdo bd<CR>", "Insert a RGBA color" }, -- <M-w>
	},
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })
