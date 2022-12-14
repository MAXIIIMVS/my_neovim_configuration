local u = require("utils")
local opts = { noremap = true, silent = true }

require("which-key").setup({
	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		winblend = 0,
	},
})

u.map("n", "<c-h>", "<cmd>WhichKey<CR>", opts)
