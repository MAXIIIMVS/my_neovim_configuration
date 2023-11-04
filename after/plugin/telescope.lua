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
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "flex",
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { truncate = 3 },
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
		emoji = {
			action = function(emoji)
				vim.fn.setreg("*", emoji.value) -- copy to * register, paste it with p or "*p
				-- insert emoji when picked
				vim.api.nvim_put({ emoji.value }, "c", false, true)
			end,
		},
		glyph = {
			action = function(glyph)
				vim.fn.setreg("*", glyph.value)
				vim.api.nvim_put({ glyph.value }, "c", false, true)
			end,
		},
		zoxide = {
			prompt_title = "Projects",
			mappings = {
				["<C-b>"] = {
					action = function(selection)
						vim.cmd("Telescope file_browser path=" .. selection.path .. " select_buffer=true")
					end,
					after_action = function(selection)
						vim.notify("Directory changed to " .. selection.path)
					end,
				},
			},
		},
	},

	extensions_list = { "fzf", "file_browser", "emoji", "glyph", "zoxide" },
}

telescope.setup(options)

pcall(function()
	for _, ext in ipairs(options.extensions_list) do
		telescope.load_extension(ext)
	end
end)
