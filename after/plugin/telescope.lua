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
				preview_width = 0.55,
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
		file_ignore_patterns = { "node_modules", "tags" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { truncate = 3 },
		-- path_display = { "filename_first" },
		winblend = 0,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
				["<C-c>"] = require("telescope.actions").close,
				["<M-h>"] = "which_key",
				["<C-r>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
			}, -- n
			i = {
				["<M-h>"] = "which_key",
				["<C-r>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
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

require("telescope").setup(options)

pcall(function()
	for _, ext in ipairs(options.extensions_list) do
		require("telescope").load_extension(ext)
	end
end)
