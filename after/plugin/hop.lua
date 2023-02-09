local wk = require("which-key")

require("hop").setup()

wk.register({
	[";"] = {
		w = { "<cmd>HopWordMW<CR>", "Hop to a word" },
		c = { "<cmd>HopChar1MW<CR>", "Hop to a character" },
		p = { "<cmd>HopPatternMW<CR>", "Hop to a pattern" },
		l = { "<cmd>HopLineMW<CR>", "Hop to a line" },
	},
}, { prefix = "", noremap = true, silent = true, nowait = true })
