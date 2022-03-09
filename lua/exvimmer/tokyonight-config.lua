-- NOTE:❗️configuration needs to be set BEFORE loading the color scheme with colorscheme tokyonight
--
local g = vim.g

g.tokyonight_style = 'storm' -- night, storm or day
g.tokyonight_terminal_colors = true
g.tokyonight_italic_comments = false
g.tokyonight_italic_keywords = false
g.tokyonight_italic_functions = false
g.tokyonight_italic_variables = false
g.tokyonight_transparent = false
g.tokyonight_hide_inactive_statusline = false
-- g.tokyonight_sidebars = {}
g.tokyonight_transparent_sidebar = false
g.tokyonight_dark_sidebar = true
g.tokyonight_dark_float = true
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
g.tokyonight_day_brightness = 0.3 -- 0-1
g.tokyonight_lualine_bold = false
