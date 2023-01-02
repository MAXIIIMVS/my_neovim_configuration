local present, wk = pcall(require, "which-key")

if not present then
	return
end

local options = {
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		winblend = 0,
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	layout = {
		spacing = 6, -- spacing between columns
	},
}

wk.setup(options)

vim.keymap.set("n", "<M-h>", "<cmd>WhichKey<CR>", { noremap = true, silent = true })
