local present, catppuccin = pcall(require, "catppuccin")

if not present then
	return
end

local telescopeBorderless = function(flavor)
	local cp = require("catppuccin.palettes").get_palette(flavor)

	return {
		TelescopeSelectionCaret = { fg = cp.flamingo },
		TelescopeSelection = { fg = cp.text, bg = cp.surface0, bold = true },
		TelescopeMatching = { fg = cp.flamingo },
		TelescopePromptPrefix = { bg = "#0c0c17" },
		TelescopePromptNormal = { bg = "#0c0c17" },
		TelescopePromptBorder = { bg = "#0c0c17", fg = "#0c0c17" },
		TelescopePromptTitle = { bg = cp.pink, fg = cp.mantle },
		TelescopeResultsNormal = { bg = "#10101E" },
		TelescopeResultsBorder = { bg = "#10101E", fg = "#10101E" },
		TelescopeResultsTitle = { default = false, fg = cp.text },
		TelescopePreviewNormal = { bg = "#0C0C17" },
		TelescopePreviewBorder = { bg = "#0c0c17", fg = "#0c0c17" },
		TelescopePreviewTitle = { bg = cp.green, fg = cp.mantle },
	}
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
		dashboard = true,
		telescope = true,
		which_key = true,
		treesitter = true,
		hop = true,
		mason = true,
		ts_rainbow = true,
		noice = true,
		notify = true,
		-- For more plugins integrations please scroll down
		-- (https://github.com/catppuccin/nvim#integrations)
	},
	highlight_overrides = {
		-- latte = telescopeBorderless("latte"),
		-- frappe = telescopeBorderless("frappe"),
		-- macchiato = telescopeBorderless("macchiato"),
		-- mocha = telescopeBorderless("mocha"),
	},
}

catppuccin.setup(options)
vim.cmd.colorscheme("catppuccin")
