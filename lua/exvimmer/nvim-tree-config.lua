vim.g.nvim_tree_width = 25
vim.g.nvim_tree_indent_markers = 1

require'nvim-tree'.setup {
	-- auto_open = true,
	-- auto_close = true,
	gitignore = 1,
	actions = {
		open_file = {
			quit_on_open = true
		}
	},
	view = {
		-- side = 'right',
		preserve_window_proportions = true
	},
	diagnostics = {
		-- TODO: check docs
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		}
	},
}
