local u = require('utils')
local cmd = vim.cmd
local opts = { noremap = true, silent = true }
-- MAPPINGS {{{
-- ---------------------------------------------------------------------
-- source the file
u.map('n', '<leader>s', ':so %<CR>')
-- set filetype
u.map('n', '<leader>y', ':set filetype=')

-- open the current file with the default app in linux
u.map('n', '<leader>o', ':!xdg-open %<CR>', opts)
u.map('n', '<leader>O', ':!xdg-open .<CR>', opts)

-- run prettier in the current directory
u.map('n', '<leader>P',
  ':silent !cd ' .. u.get_top_level() .. '&& prettier --ignore-path .gitignore -w .<CR>:bd<CR><c-o>',
  opts)
u.map('n', '<leader>p', ':silent !prettier --ignore-path .gitignore -w %<CR>:bd<CR><c-o>', opts)

-- close and open the file again
u.map('n', '<leader>r', ':bd<CR><c-o>', opts)

-- Ctrl+c = ESC, but I use Ctrl+[
u.map('n', '<c-c>', '<ESC>')
u.map('v', '<c-c>', '<ESC>')
u.map('i', '<c-c>', '<ESC>')
u.map('s', '<c-c>', '<ESC>')

-- Resize window
u.map('n', '<c-w><left>', '<c-w><')
u.map('n', '<c-w><right>', '<c-w>>')
u.map('n', '<c-w><up>', '<c-w>-')
u.map('n', '<c-w><down>', '<c-w>+')

--insert a blank line around the cursor
u.map('n', ']<space>', 'o<ESC>k')
u.map('n', '[<space>', 'O<ESC>j')

-- Switch between windows
u.map('n', '<space>j', '<c-w>j', opts)
u.map('n', '<space>k', '<c-w>k', opts)
u.map('n', '<space>l', '<c-w>l', opts)
u.map('n', '<space>h', '<c-w>h', opts)

-- next and previous buffer
-- u.map('n', '<S-Tab>', ':bprev<CR>', opts)
-- u.map('n', '<Tab>', ':bnext<CR>', opts)
u.map('n', ';;', ':bd<CR>', opts)
-- close the window
u.map('n', ';q', '<c-w>q')

-- substitution and insertion in visual mode
u.map('n', ';s', ':s/')
u.map('v', ';s', ':s/')
u.map('s', ';s', '<ESC>:s/')

-- delete all buffers other than the current one, put the cursor back
-- nnoremap <space>bo :%bd\|e#\|bd#<CR>\|'"
u.map('n', '<space>bo', ':%bd|e#|bd#<CR>|\'"', { noremap = true })

-- delete all buffers
u.map('n', '<space>ba', ':bufdo bd<CR>')

u.map('i', '<c-a>', '<c-o>I', opts)
u.map('i', '<c-e>', '<c-o>A', opts)
u.map('i', '<c-k>', '<c-o>C', opts)
u.map('i', '<c-u>', '<LEFT><c-o>v0x', opts)
-- u.map('i', '<c-y>', '<ESC>pa', {noremap = true})
u.map('i', '<c-t>', '<ESC>x<LEFT>P<RIGHT>a', opts)
u.map('i', '<c-f>', '<RIGHT>', opts)
u.map('i', '<c-b>', '<LEFT>', opts)
u.map('i', '<M-b>', '<C-LEFT>', opts)
u.map('i', '<M-f>', '<C-RIGHT>', opts)
u.map('i', '<M-d>', '<C-o>de', opts)
u.map('s', '<M-d>', '<ESC>dei', opts)

-- Enter -> :noh
u.map('n', '<CR>', ':noh<CR><CR>', opts)

-- write to buffer only if buffer has changed: Ctrl+s -> :update
u.map('n', '<c-s>', ':noh<CR>:update<CR>', { noremap = true })
u.map('i', '<c-s>', '<ESC>:noh<CR>:update<CR>', { noremap = true })
u.map('v', '<c-s>', '<ESC>:noh<CR>:update<CR>', { noremap = true })
u.map('s', '<c-s>', '<ESC>:noh<CR>:update<CR>', { noremap = true })
-- NOTE: use :w to write to the buffer intentionally, don't use keymaps

-- Alt+s -> :wall
u.map('n', '<M-s>', ':noh<CR>:wall<CR>', { noremap = true })
u.map('i', '<M-s>', '<ESC>:noh<CR>:wall<CR>', { noremap = true })
u.map('v', '<M-s>', '<ESC>:noh<CR>:wall<CR>', { noremap = true })
u.map('s', '<M-s>', '<ESC>:noh<CR>:wall<CR>', { noremap = true })

-- Delete the characer after cursor
u.map('i', '<C-d>', '<Del>', opts)
u.map('s', '<C-d>', '<ESC><Del>i', opts)

-- make . to work with visually selected lines
u.map('v', '.', ':normal.<CR>', opts)

-- Move visual selection
u.map('v', '<c-j>', ':m \'>+1<CR>gv=gv', opts)
u.map('v', '<c-k>', ':m \'<-2<CR>gv=gv', opts)

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
u.map('n', '<space>e', ':NvimTreeToggle<CR>', opts)

-- telescope
u.map('n', ';f', ':Telescope find_files cwd=' .. u.get_top_level() .. '<CR>', opts)
u.map('n', ';F', ':Telescope find_files hidden=true cwd=' .. u.get_top_level() .. '<CR>', opts)
u.map('n', ';g', ':Telescope live_grep cwd=' .. u.get_top_level() .. '<CR>', opts)
u.map('n', ';G', ':Telescope live_grep hidden=true cwd=' .. u.get_top_level() .. '<CR>', opts)
u.map('n', ';b', ':Telescope buffers<CR>', opts)
u.map('n', ';t', ':TodoTelescope cwd=' .. u.get_top_level() .. '<CR>', opts)
u.map('n', ';o', ':Telescope oldfiles<CR>', opts)
u.map('n', ';d', ':Telescope diagnostics cwd=' .. u.get_top_level() .. '<CR>', opts)
u.map('n', ';<space>', ':Telescope<CR>', opts)

-- lsp
u.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
u.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
u.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
u.map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
u.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
u.map('n', '<leader>f', ':lua vim.lsp.buf.format {async = true}<CR>', opts)
u.map('n', '<space>mI', ':Mason<CR>', opts)
u.map('n', '<space>mi', ':LspInfo<CR>', opts)
u.map('n', '<space>ms', ':LspStart<CR>', opts)
u.map('n', '<space>mx', ':LspStop<CR>', { noremap = true })

-- maximizer
u.map('n', '<leader>m', ':MaximizerToggle<CR>', opts)

-- choosewin
-- u.map('n', '<space>w', ':ChooseWin<CR>', opts)

-- vim-fugitive
u.map('n', '<space>gs', ':G<CR>', opts)
u.map('n', '<space>gS', ':G switch ', { noremap = true })
u.map('n', '<space>gf', ':G fetch<CR>', opts)
u.map('n', '<space>gP', ':G push<CR>', opts)
u.map('n', '<space>gp', ':G pull<CR>', opts)
u.map('n', '<space>gl', ':G log --decorate<CR>', opts)
u.map('n', '<space>gL', ':G log --decorate -p<CR>', opts)
u.map('n', '<space>gc', ':G commit<CR>', opts)
u.map('n', '<space>gC', ':G commit --amend<CR>', opts)
u.map('n', '<space>gd', ':Gvdiffsplit<CR>', opts)
u.map('n', '<space>gb', ':G blame<CR>', opts)
u.map('n', '<space>go', ':GBrowse<CR>', opts)
-- git related telescope
-- u.map('n', ';gb', ':Telescope git_branches<CR>', opts)

-- vCoolor.vim
u.map('i', '<M-h>', '<c-o>:VCoolor<CR>', opts) -- for hex color
-- other shortcuts are alt-v (for hsl) alt-r (rgb) alt-w (rgba) and alt-c
-- }}}
