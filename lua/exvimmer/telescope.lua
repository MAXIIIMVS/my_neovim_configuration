-- function telescope_buffer_dir()
--   return vim.fn.expand('%:p:h')
-- end
--
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
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.6,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.90,
			height = 0.80,
			preview_cutoff = 0,
		},
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = {
				["q"] = actions.close,
				-- ["<C-h>"] = "which_key",
				-- ["<C-r>"] = "delete_buffer",
			}, -- n
			i = {
				-- ["<C-h>"] = "which_key",
				-- ["<C-r>"] = "delete_buffer",
			}, -- i
		}, -- mappings
	},

	-- extensions_list = { "file_browser", "themes", "terms" },
	extensions_list = { "file_browser" },
}

telescope.setup(options)

pcall(function()
	for _, ext in ipairs(options.extensions_list) do
		telescope.load_extension(ext)
	end
end)
