local wk = require("which-key")

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
vim.keymap.set("v", "<c-_>", ":Commentary<CR>", { noremap = true, silent = true, desc = "Toggle comment in this line" })
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

wk.register({
	c = {
		name = "Comment",
		t = { "ITODO: <ESC><cmd>silent Commentary<CR>f:a ", "TODO comment this line" },
		T = { "OTODO: <ESC><cmd>silent Commentary<CR>f:a ", "TODO comment above this line" },
		e = { "ITEST: <ESC><cmd>silent Commentary<CR>f:a ", "TEST comment this line" },
		E = { "OTEST: <ESC><cmd>silent Commentary<CR>f:a ", "TEST comment above this line" },
		N = { "ONOTE: <ESC><cmd>silent Commentary<CR>f:a ", "NOTE comment above this line" },
		n = { "INOTE: <ESC><cmd>silent Commentary<CR>^", "NOTE comment this line" },
		F = { "OFIX: <ESC><cmd>silent Commentary<CR>f:a ", "FIX comment above this line" },
		f = { "IFIX: <ESC><cmd>silent Commentary<CR>^", "FIX comment this line" },
		W = { "OWARNING: <ESC><cmd>silent Commentary<CR>f:a ", "WARNING comment above this line" },
		w = { "IWARNING: <ESC><cmd>silent Commentary<CR>^", "WARNING comment this line" },
		H = { "OHACK: <ESC><cmd>silent Commentary<CR>f:a ", "HACK comment above this line" },
		h = { "IHACK: <ESC><cmd>silent Commentary<CR>^", "HACK comment this line" },
		P = { "OPERF: <ESC><cmd>silent Commentary<CR>f:a ", "PERF comment above this line" },
		p = { "IPERF: <ESC><cmd>silent Commentary<CR>^", "PERF comment this line" },
		l = { "<cmd>silent  TodoLocList<CR>", "List all local comments" },
		q = { "<cmd>silent TodoQuickFix<CR>", "List all comments as Quickfix" },
	},
}, { prefix = "<space>", mode = "n", silent = true, noremap = true, nowait = true })
