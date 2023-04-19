require("Comment").setup({
	ignore = "^$", -- ignore empty lines
	toggler = {
		line = "<C-_>",
	},
})

require("todo-comments").setup({
	keywords = {
		FIX = { icon = "🔧", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
		TODO = { icon = "⚓", color = "#00A3FF" },
		HACK = { icon = "💀", color = "#F945C1" },
		WARN = { icon = "⚠️ ", color = "#FBBF24", alt = { "WARNING", "XXX" } },
		PERF = { icon = "🎭", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = "📝", color = "#10B981", alt = { "INFO" } },
		TEST = { icon = "🛡️", color = "#FFFD00", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	highlight = {
		multiline = true, -- enable multiline todo comments
		comments_only = true,
		-- exclude = {}, -- list of file types to exclude highlighting
	},
})
