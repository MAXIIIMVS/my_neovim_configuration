local u = require("utils")
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

u.map("n", "<space>gs", ":silent vertical G<CR>", opts)
u.map("n", "<space>gS", ":silent G switch ", { noremap = true })
u.map("n", "<space>gf", ":silent G fetch<CR>", opts)
u.map("n", "<space>gP", ":silent G push<CR>", opts)
u.map("n", "<space>gp", ":silent G pull<CR>", opts)
u.map("n", "<space>gl", ":silent vertical G log --decorate<CR>", opts)
u.map("n", "<space>gL", ":silent vertical G log --decorate -p<CR>", opts)
u.map("n", "<space>gn", ":silent vertical G log --stat<CR>", opts)
u.map("n", "<space>gc", ":silent vertical G commit<CR>", opts)
u.map("n", "<space>gC", ":silent vertical G commit --amend<CR>", opts)
u.map("n", "<space>gd", ":silent Gvdiffsplit<CR>", opts)
u.map("n", "<space>gD", ":silent Gvdiffsplit HEAD~<CR>", opts)
u.map("n", "<space>gb", ":silent G blame<CR>", opts)
u.map("n", "<space>gB", ":Gitsigns blame_line<CR>", opts)
u.map("n", "<space>go", ":silent GBrowse<CR>", opts)
u.map("n", "<space>gO", ":silent G checkout ", opts)
u.map("n", "<space>gr", ":Gitsigns reset_hunk<CR>", opts)
u.map("n", "<space>gR", ":Gitsigns toggle_deleted<CR>", opts)
u.map("n", "<space>gv", ":Gitsigns preview_hunk<CR>", opts)
u.map("n", "<space>gV", ":Gitsigns toggle_current_line_blame<CR>", opts)
u.map("n", "<space>g[", ":silent G checkout HEAD^<CR>", opts)
u.map(
	"n",
	"<space>g]",
	":silent !git checkout $(git rev-list --topo-order HEAD..$(git remote show origin | sed -n '/HEAD branch/s/.*: //p') | tail -1)<CR>",
	opts
)
u.map("n", "]c", ":Gitsigns next_hunk<CR>", opts)
u.map("n", "[c", ":Gitsigns prev_hunk<CR>", opts)
