local present, catppuccin = pcall(require, "catppuccin")

if not present then
	return
end

---@diagnostic disable-next-line: unused-local, unused-function
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

catppuccin.setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	show_end_of_buffer = false,
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	transparent_background = true,
	term_colors = true,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.45,
	},
	styles = {
		comments = { "bold" },
	},
	color_overrides = {
		mocha = {
			base = "#1A1A2F",
		},
	},
	custom_highlights = {},
	highlight_overrides = {
		-- latte = telescopeBorderless("latte"),
		-- frappe = telescopeBorderless("frappe"),
		-- macchiato = telescopeBorderless("macchiato"),
		-- mocha = telescopeBorderless("mocha"),
	},
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
		lsp_saga = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		-- (https://github.com/catppuccin/nvim#integrations)
	},
})

vim.keymap.set("n", "<leader>c", "<cmd>silent CatppuccinCompile<CR>")
vim.cmd.colorscheme("catppuccin")
