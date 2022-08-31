require 'nvim-tree'.setup {
  -- auto_resize = true,
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
    width = 33,
    preserve_window_proportions = true
  },
  diagnostics = {
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
  filters = {
    dotfiles = true,
    custom = { ".git" },
    exclude = { ".gitignore", ".env", ".github" },
  },
}
