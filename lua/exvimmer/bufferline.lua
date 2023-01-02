local opts = { noremap = true, silent = true }

require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
			},
		},
		sort_by = "relative_directory",
		-- numbers = "ordinal",
		separator_style = "slant",
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

vim.keymap.set("n", "<S-Tab>", "::BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "<Tab>", "::BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "]B", ":BufferLineMoveNext<CR>", opts)
vim.keymap.set("n", "[B", ":BufferLineMovePrev<CR>", opts)
vim.keymap.set("n", "]x", ":BufferLineCloseRight<CR>", opts)
vim.keymap.set("n", "[x", ":BufferLineCloseLeft<CR>", opts)
vim.keymap.set("n", "<space>bp", ":BufferLinePick<CR>", opts)
vim.keymap.set("n", "<space>bP", ":BufferLinePickClose<CR>", opts)
-- vim.keymap.set('n', '<leader>g', ':BufferLineGoToBuffer ')
-- vim.keymap.set("n", ";p", ":BufferLineTogglePin<CR>", opts)
