local u = require("utils")
local opts = { noremap = true, silent = true }
local home = os.getenv("HOME")

-- MAPPINGS {{{
-- ---------------------------------------------------------------------
-- source the file
u.map("n", "<leader>s", ":so %<CR>")
-- set filetype
u.map("n", "<leader>y", ":set filetype=")

-- open the current file with the default app in linux, or use open command
u.map("n", ";o", ":silent !xdg-open %<CR>", opts)
u.map("n", ";O", ":silent !xdg-open .<CR>", opts)

-- Better indent
u.map("v", "<", "<gv", opts)
u.map("v", ">", ">gv", opts)

-- Resizing panes
u.map("n", "<C-Left>", ":vertical resize +2<CR>", opts)
u.map("n", "<C-Right>", ":vertical resize -1<CR>", opts)
u.map("n", "<C-Up>", ":resize -1<CR>", opts)
u.map("n", "<C-Down>", ":resize +1<CR>", opts)

-- Paste over currently selected text without yanking it
u.map("v", "p", '"_dP', opts)

-- run prettier in the current directory
-- u.map('n', '<leader>P',
--   ':silent !cd ' .. u.get_top_level() ..
--   '&& prettier --ignore-path .gitignore -w .<CR>', opts)
-- u.map('n', '<leader>p', ':silent !prettier --ignore-path .gitignore -w %<CR>',
--   opts)

-- close and open the file again
-- u.map('n', '<leader>r', ':bd<CR><c-o>', opts)

-- toggle rainbow off an on
u.map("n", "<leader>r", "<cmd>TSDisable rainbow<bar>TSEnable rainbow<CR>", opts)

--insert a blank line around the cursor
u.map("n", "]<space>", "o<ESC>k")
u.map("n", "[<space>", "O<ESC>j")

-- Switch between windows
u.map("n", "<space>j", "<c-w>j", opts)
u.map("n", "<space>k", "<c-w>k", opts)
u.map("n", "<space>l", "<c-w>l", opts)
u.map("n", "<space>h", "<c-w>h", opts)

-- next and previous buffer
-- u.map('n', '<S-Tab>', ':bprev<CR>', opts)
-- u.map('n', '<Tab>', ':bnext<CR>', opts)
u.map("n", ";;", ":bd<CR>", opts)
-- close the window
u.map("n", ";q", "<c-w>q")

-- substitution and insertion in visual mode
u.map("n", ";s", ":s/")
u.map("v", ";s", ":s/")
u.map("s", ";s", "<ESC>:s/")

-- delete all buffers other than the current one, put the cursor back
-- nnoremap <space>bo :%bd\|e#\|bd#<CR>\|'"
u.map("n", "<space>bo", ":%bd|e#|bd#<CR>|'\"", { noremap = true })

-- delete all buffers
u.map("n", "<space>ba", ":bufdo bd<CR>")

-- use vim-rsi instead
u.map("i", "<c-k>", "<c-o>C", opts)
u.map("s", "<M-d>", "<ESC>dei", opts)
u.map("s", "<M-b>", "<ESC>bi", opts)
u.map("s", "<M-f>", "<ESC>ei", opts)
u.map("s", "<c-e>", "<ESC>A", opts)
u.map("s", "<c-a>", "<ESC>I", opts)

-- write to buffer only if buffer has changed: Ctrl+s -> :update
u.map("n", "<c-s>", ":noh<CR>:update<CR>", { noremap = true })
u.map("i", "<c-s>", "<ESC>:noh<CR>:update<CR>", { noremap = true })
u.map("v", "<c-s>", "<ESC>:noh<CR>:update<CR>", { noremap = true })
u.map("s", "<c-s>", "<ESC>:noh<CR>:update<CR>", { noremap = true })
-- NOTE: use :w to write to the buffer intentionally, don't use keymaps

-- Alt+s -> :wall
u.map("n", "<M-s>", ":noh<CR>:wall<CR>", { noremap = true })
u.map("i", "<M-s>", "<ESC>:noh<CR>:wall<CR>", { noremap = true })
u.map("v", "<M-s>", "<ESC>:noh<CR>:wall<CR>", { noremap = true })
u.map("s", "<M-s>", "<ESC>:noh<CR>:wall<CR>", { noremap = true })

-- make . to work with visually selected lines
u.map("v", ".", ":normal.<CR>", opts)

-- Move visual selection
u.map("v", "<c-j>", ":m '>+1<CR>gv=gv", opts)
u.map("v", "<c-k>", ":m '<-2<CR>gv=gv", opts)

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

-- nvim-tree
u.map("n", "<space>e", "<cmd>NvimTreeToggle<CR>", opts)

-- telescope
u.map("n", ";f", ":Telescope find_files cwd=" .. u.get_top_level() .. "<CR>", opts)
u.map("n", ";F", ":Telescope find_files hidden=true cwd=" .. u.get_top_level() .. "<CR>", opts)
u.map("n", ";g", ":Telescope live_grep cwd=" .. u.get_top_level() .. "<CR>", opts)
u.map("n", ";G", ":Telescope live_grep hidden=true cwd=" .. u.get_top_level() .. "<CR>", opts)
u.map("n", ";b", ":Telescope buffers<CR>", opts)
u.map("n", ";d", "<cmd>Telescope file_browser cwd=" .. home .. "<CR>", opts)
u.map("n", ";t", ":TodoTelescope cwd=" .. u.get_top_level() .. "<CR>", opts)
u.map("n", ";r", ":Telescope oldfiles<CR>", opts)
u.map("n", ";E", ":Telescope diagnostics cwd=" .. u.get_top_level() .. "<CR>", opts)
u.map("n", ";h", "<cmd>Telescope help_tags<CR>", opts)
u.map("n", ";<space>", ":Telescope<CR>", opts)

-- vCoolor.vim
u.map("i", "<M-h>", "<c-o>:VCoolor<CR>", opts) -- for hex color
-- other shortcuts are alt-v (for hsl) alt-r (rgb) alt-w (rgba) and alt-c

-- zen-mode
u.map("n", ";z", "<cmd>ZenMode<CR>")

-- maximize the window
u.map("n", ";Z", "<c-w>|<c-w>_")

-- dashboard
u.map("n", ";i", "<cmd>Dashboard<CR>", opts)
-- }}}
