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
	transparent_background = vim.o.background == "dark",
	term_colors = true,
	color_overrides = {
		mocha = {
			-- base = "#1A1A2F",
			-- base = "#171421",
			base = "#1D182E",
		},
	},
	highlight_overrides = {
		-- latte = telescopeBorderless("latte"),
		-- frappe = telescopeBorderless("frappe"),
		-- macchiato = telescopeBorderless("macchiato"),
		-- mocha = telescopeBorderless("mocha"),
		mocha = function()
			-- return {
			-- 	-- ["@text.todo"] = { fg = "#FF007A", bg = "#171421" },
			-- 	["@text.todo"] = { fg = "#FF1C7B", bg = "#171421" },
			-- 	["@text.note"] = { fg = "#0AF106", bg = "#171421" },
			-- 	["@text.warning"] = { fg = "#F0FD00", bg = "#171421" },
			-- }
		end,
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		dashboard = true,
		dap = {
			enabled = true,
			enable_ui = true, -- enable nvim-dap-ui
		},
		telescope = {
			enabled = true,
			-- style = "nvchad",
		},
		which_key = false,
		treesitter = true,
		mason = false,
		nvimtree = true,
		lsp_saga = false,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		mini = true,
		vimwiki = true,
		-- (https://github.com/catppuccin/nvim#integrations)
	},
})

vim.cmd.colorscheme("catppuccin")
