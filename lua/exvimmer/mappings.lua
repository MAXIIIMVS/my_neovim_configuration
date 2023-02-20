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

-- }}}
