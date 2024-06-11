local saga = require("lspsaga")

saga.setup({
	hover = {
		max_width = 0.7,
	},
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
		enable = false,
		virtual_text = false,
		-- debounce = 0,
	},
	outline = {
		win_width = 40,
	},
	symbol_in_winbar = {
		enable = true, -- don't toggle
		hide_keyword = false,
		folder_level = 3,
		color_mode = true,
		delay = 0,
	},
	beacon = {
		enable = false,
	},
})
