local wk = require("which-key")
local opts = { noremap = true, silent = true }

require("gitsigns").setup({
	attach_to_untracked = true,
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
		delay = 0,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author> <author_mail>: <summary>",
})

vim.cmd("highlight GitSignsCurrentLineBlame guifg=#666666")

vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true, desc = "Jump to the next hunk" })
vim.keymap.set(
	"n",
	"[c",
	":Gitsigns prev_hunk<CR>",
	{ noremap = true, silent = true, desc = "Jump to the previous hunk" }
)

wk.register({
	g = {
		name = "Git",
		s = { ":silent vertical Git<CR>", "Status" },
		S = { ":silent G switch ", "Switch", silent = false },
		f = { ":silent G fetch<CR>", "Fetch" },
		P = { ":silent G push<CR>", "Push" },
		p = { ":silent G pull<CR>", "Pull" },
		l = { ":silent vertical G log --decorate<CR>", "Log" },
		L = { ":silent vertical G log --decorate -p<CR>", "Log with differences" },
		n = { ":silent vertical G log --stat<CR>", "Log with stats" },
		c = { ":silent vertical G commit<CR>", "Commit" },
		C = { ":silent G checkout ", "Checkout" },
		["["] = { ":silent G checkout HEAD^<CR>", "Checkout previous commit" },
		["]"] = {
			":silent !git checkout $(git rev-list --topo-order HEAD..$(git remote show origin | sed -n '/HEAD branch/s/.*: //p') | tail -1)<CR>",
			"Checkout next commit",
		},
		a = {
			":silent vertical G commit --amend<CR>",
			"Amend commit with staged changes",
		},
		d = { ":silent Gvdiffsplit<CR>", "Diff" },
		D = { ":silent Gvdiffsplit HEAD~<CR>", "Diff with previous commit" },
		b = { ":silent G blame<CR>", "Blame on the current file" },
		B = { ":Gitsigns blame_line<CR>", "Blame on the current line" },
		o = { ":silent GBrowse<CR>", "Open in the browser" },
		r = {
			":Gitsigns reset_hunk<CR>",
			"Reset the lines of the hunk at the cursor position, or all lines in the given range.",
		},
		R = { ":Gitsigns toggle_deleted<CR>", "Toggle deleted lines" },
		v = { ":Gitsigns preview_hunk<CR>", "Preview hunk" },
		V = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
	},
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })
