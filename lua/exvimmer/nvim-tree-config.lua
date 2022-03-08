vim.g.nvim_tree_width = 25
vim.g.nvim_tree_indent_markers = 1

require'nvim-tree'.setup {
	-- auto_open = true,
	-- auto_close = true,
	gitignore = 1,
	view = {
		side = 'right',
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
	open_file = {
		quit_on_open = true
		-- TODO: find a way to close nvim-tree after opening a file
	},
}
