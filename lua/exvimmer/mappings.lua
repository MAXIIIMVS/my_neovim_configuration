local has_wk, wk = pcall(require, "which-key")
if not has_wk then
	return
end
local utils = require("utils")
local opts = { noremap = true, silent = true }

-- TODO: map all remaps to which-key

-- MAPPINGS {{{
-- ---------------------------------------------------------------------
-- source the file
vim.keymap.set("n", "<leader>s", ":silent so %<CR>", opts)

vim.keymap.set("n", "<leader>d", "<cmd>silent Dashboard<CR>", opts)

-- make the file executable for the (u)ser , don't change (g)roup and (o)ther
-- permissions
vim.keymap.set("n", "<leader>x", "<cmd>silent !chmod u+x %<CR>", opts)

-- select all
vim.keymap.set("n", "<leader>a", "ggVG", opts)

-- Better indent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Resizing panes
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -1<CR>", opts)
vim.keymap.set("n", "<C-Up>", ":resize -1<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +1<CR>", opts)

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', opts)

-- run prettier in the current directory
-- vim.keymap.set('n', '<leader>P',
--   ':silent !cd ' .. utils.get_top_level() ..
--   '&& prettier --ignore-path .gitignore -w .<CR>', opts)
-- vim.keymap.set('n', '<leader>p', ':silent !prettier --ignore-path .gitignore -w %<CR>',
--   opts)

-- close and open the file again
-- vim.keymap.set('n', '<leader>r', ':bd<CR><c-o>', opts)

-- toggle rainbow off an on
vim.keymap.set("n", "<leader>r", "<cmd>TSDisable rainbow<bar>TSEnable rainbow<CR>", opts)

--insert a blank line around the cursor
vim.keymap.set("n", "]<space>", "o<ESC>k")
vim.keymap.set("n", "[<space>", "O<ESC>j")

-- see next/previous and first/last items in QuickFix
vim.keymap.set("n", "[q", "<cmd>silent cprev<CR>")
vim.keymap.set("n", "]q", "<cmd>silent cnext<CR>")
vim.keymap.set("n", "[Q", "<cmd>silent cfirst<CR>")
vim.keymap.set("n", "]Q", "<cmd>silent clast<CR>")

-- see next/previous and first/last items in local list
vim.keymap.set("n", "[l", "<cmd>silent lprev<CR>")
vim.keymap.set("n", "]l", "<cmd>silent lnext<CR>")
vim.keymap.set("n", "[L", "<cmd>silent lfirst<CR>")
vim.keymap.set("n", "]L", "<cmd>silent llast<CR>")

vim.keymap.set("n", ";B", function()
	vim.o.background = vim.o.background == "dark" and "light" or "dark"
end)

-- next and previous buffer
-- vim.keymap.set("n", "[b", ":bprev<CR>", opts)
-- vim.keymap.set("n", "]b", ":bnext<CR>", opts)

-- use vim-rsi instead
vim.keymap.set("i", "<c-k>", "<c-o>C", opts)
vim.keymap.set("s", "<M-d>", "<ESC>dei", opts)
vim.keymap.set("s", "<M-b>", "<ESC>bi", opts)
vim.keymap.set("s", "<M-f>", "<ESC>ei", opts)
vim.keymap.set("s", "<c-e>", "<ESC>A", opts)
vim.keymap.set("s", "<c-a>", "<ESC>I", opts)

-- write to buffer only if buffer has changed: Ctrl+s -> :update
vim.keymap.set("n", "<c-s>", "<cmd>silent update<CR>", opts)
vim.keymap.set("i", "<c-s>", "<ESC><cmd>silent update<CR>", opts)
vim.keymap.set("v", "<c-s>", "<ESC><cmd>silent update<CR>", opts)
vim.keymap.set("s", "<c-s>", "<ESC><cmd>silent update<CR>", opts)
-- NOTE: use :w to write to the buffer intentionally, don't use keymaps

-- Alt+s -> :wall
vim.keymap.set("n", "<M-s>", "<cmd>wall<CR>", opts)
vim.keymap.set("i", "<M-s>", "<ESC><cmd>wall<CR>", opts)
vim.keymap.set("v", "<M-s>", "<ESC><cmd>wall<CR>", opts)
vim.keymap.set("s", "<M-s>", "<ESC><cmd>wall<CR>", opts)

-- make . to work with visually selected lines
vim.keymap.set("v", ".", ":normal.<CR>", opts)

-- Move visual selection
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv", opts)

-- search the visually selected text, not required in nvim>0.8
-- cmd([[
-- vnoremap <silent> * :<C-U>
--   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--   \gvy/<C-R><C-R>=substitute(
--   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--   \gV:call setreg('"', old_reg, old_regtype)<CR>
-- vnoremap <silent> # :<C-U>
--   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--   \gvy?<C-R><C-R>=substitute(
--   \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--   \gV:call setreg('"', old_reg, old_regtype)<CR>
-- ]])

-- vCoolor.vim
vim.keymap.set("i", "<M-V>", "<c-o>:VCoolor<CR>", opts) -- for hex color
-- other shortcuts are alt-v (for hsl) alt-r (rgb) alt-w (rgba) and alt-c

wk.register({
	[";"] = {
		name = "Quick",
		["1"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "Go to 1st buffer" },
		["2"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "Go to 2nd buffer" },
		["3"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "Go to 3rd buffer" },
		["4"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "Go to 4th buffer" },
		["5"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "Go to 5th buffer" },
		z = { "<cmd>ZenMode<CR><cmd>redraw<CR>", "Toggle Zen Mode" },
		Z = { "<c-w>|<c-w>_", "Maximize the window" },
		e = { "<cmd>silent Telescope diagnostics cwd=" .. utils.get_top_level() .. "<CR>", "List diagnostics" },
		E = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
		o = { "<cmd>silent !xdg-open %<CR>", "Open the current file" },
		O = { "<cmd>silent !xdg-open .<CR>", "Open the current directory" },
		[";"] = { ":bd<CR>", "Delete current buffer" },
		q = { "<c-w>q", "Quit a window" },
		s = {
			[[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			"Change the word under the cursor in the line",
			silent = false,
		},
		S = {
			[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			"Change the word under the cursor in the whole file",
			silent = false,
		},
		f = { "<cmd>Telescope find_files cwd=" .. utils.get_top_level() .. "<CR>", "Find files" },
		F = { "<cmd>Telescope git_files <CR>", "Fuzzy search for files tracked by Git" },
		g = { "<cmd>Telescope live_grep  cwd=" .. utils.get_top_level() .. "<CR>", "Live grep" },
		G = { "<cmd>Telescope grep_string cwd=" .. utils.get_top_level() .. "<CR>", "Grep string under the cursor" },
		b = { "<cmd>Telescope buffers<CR>", "List open buffers" },
		C = {
			function()
				require("telescope.builtin").colorscheme()
			end,
			"List open buffers",
		},
		d = { "<cmd>Telescope file_browser cwd=" .. utils.get_top_level() .. "<CR>", "File/Folder browser" },
		j = { "<cmd>silent Telescope emoji<CR>", "Emoji" },
		t = { "<cmd>TodoTelescope cwd=" .. utils.get_top_level() .. "<CR>", "Show Todos for current project" },
		T = { "<cmd>Telescope ToggleLSP<CR>", "Toggle LSP" },
		r = { "<cmd>Telescope oldfiles<CR>", "Show recently opened files" },
		h = { "<cmd>Telescope help_tags<CR>", "Show help tags" },
		u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },
		["<space>"] = { "<cmd>Telescope<CR>", "Telescope builtins" },
	},
}, { prefix = "", noremap = true, silent = true, nowait = true })

wk.register({
	s = {
		name = "Session",
		m = { "<cmd>Obsession " .. utils.get_top_level() .. "<CR>", "Make a session" },
		d = { "<cmd>Obsession!<CR>", "Delete the session" },
	},
	b = {
		name = "buffer",
		o = { "<cmd>silent %bd|e#|bd#<CR>|'\"", "close other buffers, put the cursor back" },
		a = { "<cmd>bufdo bd<CR>", "close all buffers" },
	},
	j = { "<c-w>j", "go N windows down" },
	k = { "<c-w>k", "go N windows up" },
	h = { "<c-w>h", "go N windows right" },
	l = { "<c-w>l", "go N windows left" },
	e = { "<cmd>silent NvimTreeToggle<CR>", "Toggle NvimTree" },
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })
-- }}}
