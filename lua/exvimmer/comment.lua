local wk = require("which-key")

require("nvim_comment").setup({
	comment_empty = false,
})

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
		multiline = true, -- enable multine todo comments
		comments_only = false,
		-- exclude = {}, -- list of file types to exclude highlighting
	},
})

vim.keymap.set(
	"n",
	"<c-_>",
	":CommentToggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle comments in this line" }
)
vim.keymap.set(
	"v",
	"<c-_>",
	":CommentToggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle comments in this line" }
)
vim.keymap.set(
	"i",
	"<c-_>",
	"<ESC>:CommentToggle<CR>",
	{ noremap = true, silent = true, desc = "Toggle comments in this line" }
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
		t = { "ITODO: <ESC>:CommentToggle<CR>f:a ", "TODO comment this line" },
		T = { "OTODO: <ESC>:CommentToggle<CR>f:a ", "TODO comment above this line" },
		e = { "ITEST: <ESC>:CommentToggle<CR>f:a ", "TEST comment this line" },
		E = { "OTEST: <ESC>:CommentToggle<CR>f:a ", "TEST comment above this line" },
		N = { "ONOTE: <ESC>:CommentToggle<CR>f:a ", "NOTE comment above this line" },
		n = { "INOTE: <ESC>:CommentToggle<CR>^", "NOTE comment this line" },
		F = { "OFIX: <ESC>:CommentToggle<CR>f:a ", "FIX comment above this line" },
		f = { "IFIX: <ESC>:CommentToggle<CR>^", "FIX comment this line" },
		W = { "OWARNING: <ESC>:CommentToggle<CR>f:a ", "WARNING comment above this line" },
		w = { "IWARNING: <ESC>:CommentToggle<CR>^", "WARNING comment this line" },
		H = { "OHACK: <ESC>:CommentToggle<CR>f:a ", "HACK comment above this line" },
		h = { "IHACK: <ESC>:CommentToggle<CR>^", "HACK comment this line" },
		P = { "OPERF: <ESC>:CommentToggle<CR>f:a ", "PERF comment above this line" },
		p = { "IPERF: <ESC>:CommentToggle<CR>^", "PERF comment this line" },
		l = { ":TodoLocList<CR>", "List all local comments" },
	},
}, { prefix = "<space>", mode = "n", silent = true, noremap = true, nowait = true })
