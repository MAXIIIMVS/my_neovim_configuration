local wk = require("which-key")
local opts = { noremap = true, silent = true }

require("hop").setup()

wk.register({
	[";"] = {
		w = { "<cmd>HopWordMW<CR>", "Hop to a word" },
		c = { "<cmd>HopChar1MW", "Hop to a character" },
		p = { "<cmd>HopPatternMW", "Hop to a pattern" },
		l = { "<cmd>HopLineMW", "Hop to a line" },
	},
}, { prefix = "", noremap = true, silent = true, nowait = true })
