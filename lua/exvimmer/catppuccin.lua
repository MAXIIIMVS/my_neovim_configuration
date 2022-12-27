local present, catppuccin = pcall(require, "catppuccin")

if not present then
	return
end

local options = {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	transparent_background = false,
	term_colors = false,
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.45,
	},
	styles = {
		comments = { "bold" },
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {
		mocha = {
			base = "#1A1A2F",
		},
	},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		hop = true,
		mason = true,
		ts_rainbow = true,
		-- For more plugins integrations please scroll down
		-- (https://github.com/catppuccin/nvim#integrations)
	},
}

catppuccin.setup(options)
