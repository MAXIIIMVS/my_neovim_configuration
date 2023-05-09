-- local mocha = require("catppuccin.palettes").get_palette("mocha")

require("bufferline").setup({
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
			},
			{
				filetype = "netrw",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			},
			{
				filetype = "undotree",
				text = "Undo Tree",
				highlight = "Directory",
				separator = true,
			},
			{
				filetype = "lspsagaoutline",
				text = "Lspsaga Outline",
				highlight = "Directory",
				separator = true,
			},
		},
		sort_by = "insert_at_end",
		-- numbers = "ordinal",
		-- separator_style = "thick",
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
	},
})
