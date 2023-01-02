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

vim.keymap.set("n", "<space>gs", ":silent vertical G<CR>", opts)
vim.keymap.set("n", "<space>gS", ":silent G switch ", { noremap = true })
vim.keymap.set("n", "<space>gf", ":silent G fetch<CR>", opts)
vim.keymap.set("n", "<space>gP", ":silent G push<CR>", opts)
vim.keymap.set("n", "<space>gp", ":silent G pull<CR>", opts)
vim.keymap.set("n", "<space>gl", ":silent vertical G log --decorate<CR>", opts)
vim.keymap.set("n", "<space>gL", ":silent vertical G log --decorate -p<CR>", opts)
vim.keymap.set("n", "<space>gn", ":silent vertical G log --stat<CR>", opts)
vim.keymap.set("n", "<space>gc", ":silent vertical G commit<CR>", opts)
vim.keymap.set("n", "<space>gC", ":silent vertical G commit --amend<CR>", opts)
vim.keymap.set("n", "<space>gd", ":silent Gvdiffsplit<CR>", opts)
vim.keymap.set("n", "<space>gD", ":silent Gvdiffsplit HEAD~<CR>", opts)
vim.keymap.set("n", "<space>gb", ":silent G blame<CR>", opts)
vim.keymap.set("n", "<space>gB", ":Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<space>go", ":silent GBrowse<CR>", opts)
vim.keymap.set("n", "<space>gO", ":silent G checkout ", opts)
vim.keymap.set("n", "<space>gr", ":Gitsigns reset_hunk<CR>", opts)
vim.keymap.set("n", "<space>gR", ":Gitsigns toggle_deleted<CR>", opts)
vim.keymap.set("n", "<space>gv", ":Gitsigns preview_hunk<CR>", opts)
vim.keymap.set("n", "<space>gV", ":Gitsigns toggle_current_line_blame<CR>", opts)
vim.keymap.set("n", "<space>g[", ":silent G checkout HEAD^<CR>", opts)
vim.keymap.set(
	"n",
	"<space>g]",
	":silent !git checkout $(git rev-list --topo-order HEAD..$(git remote show origin | sed -n '/HEAD branch/s/.*: //p') | tail -1)<CR>",
	opts
)
vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>", opts)
vim.keymap.set("n", "[c", ":Gitsigns prev_hunk<CR>", opts)
