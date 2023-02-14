local saga = require("lspsaga")
local wk = require("which-key")

saga.setup({
	preview = {
		lines_above = 0,
		lines_below = 0,
	},
	scroll_preview = {
		scroll_down = "<C-d>",
		scroll_up = "<C-u>",
	},
	ui = {
		theme = "round",
		border = "rounded",
		winblend = 0,
		colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
		kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
	},
	outline = {
		win_width = 40,
	},
	symbol_in_winbar = {
		enable = false, -- toggle if you like
		hide_keyword = false,
		folder_level = 3,
		color_mode = true,
	},
})

wk.register({
	g = {
		-- o = { "<cmd>Lspsaga outline<CR>", "Show lsp outline" },
		-- d = { "<cmd>Lspsaga goto_definition<CR>", "Go to definition" },
		p = { "<cmd>Lspsaga peek_definition<CR>", "Show the definition in a floating windows" },
		h = { "<cmd>Lspsaga lsp_finder<CR>", "Show the defintion, reference, implementation..." },
		a = { "<cmd>Lspsaga code_action<CR>", "Code actions" },
		r = { "<cmd>Lspsaga rename<CR>", "Rename the symbol" },
	},
}, { prefix = "", noremap = true, silent = true, nowait = true })

vim.keymap.set("n", "K", "<cmd>silent Lspsaga hover_doc ++quiet<CR>", {
	noremap = true,
	silent = true,
	nowait = true,
	desc = "Hover info",
})
vim.keymap.set("n", "<M-k>", "<cmd>silent Lspsaga hover_doc ++keep ++quiet<CR>")
vim.keymap.set(
	"n",
	"[e",
	"<cmd>Lspsaga diagnostic_jump_prev<CR>",
	{ noremap = true, silent = true, desc = "Jump to the previous diagnostic" }
)
vim.keymap.set(
	"n",
	"]e",
	"<cmd>Lspsaga diagnostic_jump_next<CR>",
	{ noremap = true, silent = true, desc = "Jump to the next diagnostic" }
)
vim.keymap.set("n", "[E", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = "Jump to the previous error" })
vim.keymap.set("n", "]E", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = "Jump to the next error" })
