require("notify").setup({
	background_colour = "Normal",
	fps = 30,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	render = "default",
	stages = "static", -- "fade_in_slide_out", "slide", "fade"
	timeout = 2000,
	top_down = false,
})
