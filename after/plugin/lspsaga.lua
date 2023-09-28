local saga = require("lspsaga")

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
	lightbulb = {
		virtual_text = false,
		-- debounce = 0,
	},
	outline = {
		win_width = 40,
	},
	symbol_in_winbar = {
		enable = true, -- don't toggle
		hide_keyword = true,
		folder_level = 3,
		color_mode = true,
	},
	beacon = {
		enable = false,
	},
})

-- vim.keymap.set("n", "<M-k>", "<cmd>silent Lspsaga hover_doc ++keep ++quiet<CR>")
