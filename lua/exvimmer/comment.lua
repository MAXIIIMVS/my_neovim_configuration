local opts = { noremap = true, silent = true }

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

vim.keymap.set("n", "<c-_>", ":CommentToggle<CR>", opts)
vim.keymap.set("v", "<c-_>", ":CommentToggle<CR>", opts)
vim.keymap.set("i", "<c-_>", "<ESC>:CommentToggle<CR>", opts)
vim.keymap.set("n", "<space>cT", "OTODO: <ESC>:CommentToggle<CR>f:a ", opts)
vim.keymap.set("n", "<space>ct", "ITODO: <ESC>:CommentToggle<CR>^", opts)
vim.keymap.set("n", "<space>cE", "OTEST: <ESC>:CommentToggle<CR>f:a ", opts)
vim.keymap.set("n", "<space>ce", "ITEST: <ESC>:CommentToggle<CR>^", opts)
vim.keymap.set("n", "<space>cN", "ONOTE: <ESC>:CommentToggle<CR>f:a ", opts)
vim.keymap.set("n", "<space>cn", "INOTE: <ESC>:CommentToggle<CR>^", opts)
vim.keymap.set("n", "<space>cF", "OFIX: <ESC>:CommentToggle<CR>f:a ", opts)
vim.keymap.set("n", "<space>cf", "IFIX: <ESC>:CommentToggle<CR>^", opts)
vim.keymap.set("n", "<space>cW", "OWARNING: <ESC>:CommentToggle<CR>f:a ", opts)
vim.keymap.set("n", "<space>cw", "IWARNING: <ESC>:CommentToggle<CR>^", opts)
vim.keymap.set("n", "<space>cH", "OHACK: <ESC>:CommentToggle<CR>f:a ", opts)
vim.keymap.set("n", "<space>ch", "IHACK: <ESC>:CommentToggle<CR>^", opts)
vim.keymap.set("n", "<space>cP", "OPERF: <ESC>:CommentToggle<CR>f:a ", opts)
vim.keymap.set("n", "<space>cp", "IPERF: <ESC>:CommentToggle<CR>^", opts)
vim.keymap.set("n", "<space>cl", ":TodoLocList<CR>", opts)

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
