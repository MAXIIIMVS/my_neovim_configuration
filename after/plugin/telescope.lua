local present, telescope = pcall(require, "telescope")

if not present then
	return
end

local actions = require("telescope.actions")

local options = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.4,
				-- results_width = 0.8,
			},
			vertical = {
				prompt_position = "top",
				mirror = true,
			},
			flex = {
				flip_columns = 120,
			},
			width = 0.90,
			height = 0.85,
			preview_cutoff = 0,
		},
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = "  ",
		sorting_strategy = "ascending",
		layout_strategy = "flex",
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { truncate = 3 },
		winblend = 0,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		mappings = {
			n = {
				["q"] = actions.close,
				["<C-c>"] = actions.close,
				["<M-h>"] = "which_key",
				["<C-r>"] = actions.delete_buffer + actions.move_to_top,
			}, -- n
			i = {
				["<M-h>"] = "which_key",
				["<C-r>"] = actions.delete_buffer + actions.move_to_top,
			}, -- i
		}, -- mappings
	},
	extensions = {
		glyph = {
			action = function(glyph)
				vim.fn.setreg("*", glyph.value)
				vim.api.nvim_put({ glyph.value }, "c", false, true)
			end,
		},
		zoxide = { prompt_title = "Projects" },
	},
	extensions_list = { "fzf", "glyph", "zoxide" },
}

telescope.setup(options)

pcall(function()
	for _, ext in ipairs(options.extensions_list) do
		telescope.load_extension(ext)
	end
end)
