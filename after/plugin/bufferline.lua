local bufferline = require("bufferline")

local options = {
	offsets = {
		{
			filetype = "NvimTree",
			text = "Explorer",
			highlight = "Directory",
			separator = true, -- use a "true" to enable the default, or set your own character
		},
		{
			filetype = "netrw",
			text = "Netrw",
			highlight = "Directory",
			separator = false,
		},
		{
			filetype = "undotree",
			text = "Undo Tree",
			highlight = "Directory",
			separator = false,
		},
		{
			filetype = "sagaoutline",
			text = "Lspsaga Outline",
			highlight = "Directory",
			separator = false,
		},
	},
	sort_by = "insert_at_end",
	numbers = "ordinal",
	separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
	diagnostics = "nvim_lsp",
}

---@diagnostic disable-next-line: missing-fields
bufferline.setup({
	-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
	options = options,
})
