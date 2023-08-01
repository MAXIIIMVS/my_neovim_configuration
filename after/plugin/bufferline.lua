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
	separator_style = "slope", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
	diagnostics = "nvim_lsp",
	custom_areas = {
		right = function()
			local result = {}
			local seve = vim.diagnostic.severity
			local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
			local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
			local info = #vim.diagnostic.get(0, { severity = seve.INFO })
			local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

			if error ~= 0 then
				table.insert(result, { text = "  " .. error, guifg = "#EC5241" })
			end

			if warning ~= 0 then
				table.insert(result, { text = "  " .. warning, guifg = "#EFB839" })
			end

			if hint ~= 0 then
				table.insert(result, { text = "  " .. hint, guifg = "#A3BA5E" })
			end

			if info ~= 0 then
				table.insert(result, { text = "  " .. info, guifg = "#7EA9A7" })
			end
			return result
		end,
	},
}

bufferline.setup({
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
	options = options,
})
