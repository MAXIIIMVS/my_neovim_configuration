local opts = { noremap = true, silent = true }
local saga = require("lspsaga")
local wk = require("which-key")

saga.setup({
	preview = {
		lines_above = 0,
		lines_below = 0,
	},
	ui = {
		theme = "round",
		border = "rounded",
		winblend = 0,
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
		o = { "<cmd>Lspsaga outline<CR>", "Show lsp outline" },
		d = { "<cmd>Lspsaga goto_definition<CR>", "Go to definition" },
		p = { "<cmd>Lspsaga peek_definition<CR>", "Show the definition in a floating windows" },
		h = { "<cmd>Lspsaga lsp_finder<CR>", "Show the defintion, reference, implementation..." },
		a = { "<cmd>Lspsaga code_action<CR>", "Code actions" },
		r = { "<cmd>Lspsaga rename<CR>", "Rename the symbol" },
	},
}, { prefix = "", noremap = true, silent = true, nowait = true })

-- vim.keymap.set('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>', opts)
-- keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- Float terminal
-- vim.keymap.set("n", "<C-\\>", "<cmd>Lspsaga open_floaterm<CR>", opts)
-- if you want to pass some cli command into a terminal you can do it like this
-- open lazygit in lspsaga float terminal
-- vim.keymap.set("n", "<C-`>", "<cmd>Lspsaga open_floaterm lazygit<CR>", opts)
-- close floaterm
-- vim.keymap.set("t", "<C-\\>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)
vim.keymap.set("n", "K", "<cmd>silent Lspsaga hover_doc<CR>", {
	noremap = true,
	silent = true,
	nowait = true,
	desc = "Hover info",
})
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
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = "Jump to the previous error" })
vim.keymap.set("n", "]E", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = "Jump to the next error" })
