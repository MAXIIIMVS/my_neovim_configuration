require("colorizer").setup({
	filetypes = { "css", "scss", "html", "typescriptreact", "javascriptreact" },
	user_default_options = {
		AARRGGBB = true, -- 0xAARRGGBB hex codes
		css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "background", -- Set the display mode.
		tailwind = true, -- Enable tailwind colors
		sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
})
