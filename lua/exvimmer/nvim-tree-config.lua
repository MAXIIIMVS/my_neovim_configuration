require'nvim-tree'.setup {
  -- auto_resize = true,
  view = {
    -- side = 'right',
    width = 25

  },
  renderer = {
    indent_markers = {
      enable = true,
    }
  },
	-- auto_close = true,
  auto_reload_on_write = true,
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
			-- hint = "", -- original one
      hint = "",
			info = "",
			warning = "",
			-- error = "", -- original one
      error = ' ',
		}
	},
}
