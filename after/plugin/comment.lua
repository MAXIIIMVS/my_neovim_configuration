require("todo-comments").setup({
	keywords = {
		FIX = { icon = "🩺", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
		TODO = { icon = "⚓", color = "#00A3FF" },
		HACK = { icon = "💀", color = "#F945C1" },
		WARN = { icon = "💡", color = "#FBBF24", alt = { "WARNING", "XXX" } },
		PERF = { icon = "🎭", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = "📝", color = "#10B981", alt = { "INFO" } },
		TEST = { icon = "🛡️", color = "#FFFD00", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	highlight = {
		multiline = true, -- enable multiline todo comments
		comments_only = false,
		-- exclude = {}, -- list of file types to exclude highlighting
	},
})

vim.keymap.set("n", "<c-_>", ":Commentary<CR>", { noremap = true, silent = true, desc = "Toggle comment in this line" })
vim.keymap.set(
	"i",
	"<c-_>",
	"<ESC>:Commentary<CR>",
	{ noremap = true, silent = true, desc = "Toggle comment in this line" }
)
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
