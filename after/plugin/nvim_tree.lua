local present, nvimtree = pcall(require, "nvim-tree")

if not present then
	return
end

local options = {
	disable_netrw = false,
	hijack_netrw = false,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	renderer = {
		highlight_git = true,
		indent_markers = {
			enable = true,
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		symlink_destination = true,
	},
	auto_reload_on_write = true,
	actions = {
		open_file = {
			quit_on_open = true,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	view = {
		-- side = "right",
		width = 40,
		preserve_window_proportions = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	git = {
		enable = true,
		ignore = true,
		show_on_dirs = true,
		timeout = 400,
	},
	filters = {
		dotfiles = true,
		custom = { ".git" },
		exclude = { ".gitignore", ".env", ".github" },
	},
	filesystem_watchers = {
		enable = true,
	},
}

nvimtree.setup(options)
