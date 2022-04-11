local u = require('utils')
local cmd = vim.cmd
local opts = { noremap=true, silent=true }
-- MAPPINGS {{{
-- ---------------------------------------------------------------------
-- source the file
u.map('n', '<leader>s', ':so %<CR>')

-- quit the window
u.map('n', '<leader>q', '<c-w>q')

-- Resize window
u.map('n', '<c-w><left>', '<c-w><')
u.map('n', '<c-w><right>', '<c-w>>')
u.map('n', '<c-w><up>', '<c-w>-')
u.map('n', '<c-w><down>', '<c-w>+')

--insert a blank line around the cursor
u.map('n', ']<space>', 'o<ESC>k')
u.map('n', '[<space>', 'O<ESC>j')

-- Go to the next or previous tab
-- NOTE: you can use [t & ]t for other tasks
u.map('n', '[t', 'gT', opts)
u.map('n', ']t', 'gt', opts)

-- Switch between windows
u.map('n', '<c-j>', '<c-w>j', {noremap = true})
u.map('n', '<c-k>', '<c-w>k', {noremap = true}) -- NOTE: you need something else for signature
u.map('n', '<c-l>', '<c-w>l', {noremap = true})
u.map('n', '<c-h>', '<c-w>h', {noremap = true})

-- next and previous buffer
u.map('n', '<S-Tab>', ':bprev<CR>', opts)
u.map('n', '<Tab>', ':bnext<CR>', opts)
u.map('n', ';;', ':bd<CR>', opts)

-- delete all buffers other than the current one, put the cursor back
-- nnoremap <space>bo :%bd\|e#\|bd#<CR>\|'"
u.map('n', '<space>bo', ':%bd|e#|bd#<CR>|\'"', {noremap = true})

-- delete all buffers
u.map('n', '<space>ba', ':bufdo bd<CR>')

u.map('i', '<c-a>', '<c-o>I', {noremap = true})
u.map('i', '<c-e>', '<c-o>A', {noremap = true})
u.map('i', '<c-k>', '<c-o>C', {noremap = true})
u.map('i', '<c-u>', '<LEFT><c-o>v0x', {noremap = true})
-- u.map('i', '<c-y>', '<ESC>pa', {noremap = true})
u.map('i', '<c-t>', '<ESC>x<LEFT>P<RIGHT>a', {noremap = true})
u.map('i', '<c-f>', '<RIGHT>', {noremap = true})
u.map('i', '<c-b>', '<LEFT>', {noremap = true})
u.map('i', '<M-b>', '<C-LEFT>', opts)
u.map('i', '<M-f>', '<C-RIGHT>', opts)

-- Enter -> :noh
u.map('n', '<CR>', ':noh<CR><CR>', {noremap = true})

-- Ctrl+s -> :w
u.map('n', '<c-s>', ':w<CR>', {noremap = true})
u.map('i', '<c-s>', '<ESC>:w<CR>', {noremap = true})
u.map('v', '<c-s>', '<ESC>:w<CR>', {noremap = true})

-- Delete the characer after cursor
u.map('i', '<C-d>', '<Del>', {noremap = true})

-- make . to work with visually selected lines
u.map('v', '.', ':normal.<CR>', {noremap = true})

-- Move visual selection
u.map('v', '<c-j>', ':m \'>+1<CR>gv=gv', {noremap = true})
u.map('v', '<c-k>', ':m \'<-2<CR>gv=gv', {noremap = true})

-- repeat the last command
u.map('n', '<space>.', ':<UP><CR>', {noremap = true})

-- search the visually selected text
cmd([[
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
]])

-- nvim-tree
u.map('n', '<space>e', ':NvimTreeToggle<CR>', opts)

-- telescope
u.map('n', ';f', ':Telescope find_files<CR>', opts)
u.map('n', ';r', ':Telescope live_grep<CR>', opts)
u.map('n', ';R', ':Telescope registers<CR>', opts)
u.map('n', ';h', ':Telescope help_tags<CR>', opts)
u.map('n', ';H', ':Telescope search_history<CR>', opts)
u.map('n', ';C', ':Telescope commands<CR>', opts)
u.map('n', ';c', ':Telescope colorscheme<CR>', opts)
u.map('n', ';b', ':Telescope buffers<CR>', opts)
u.map('n', ';T', ':Telescope tags<CR>', opts)
u.map('n', ';m', ':Telescope marks<CR>', opts)
u.map('n', ';o', ':Telescope oldfiles<CR>', opts)
u.map('n', ';d', ':Telescope diagnostics<CR>', opts)
-- todo comment
u.map('n', ';t', ':TodoTelescope<CR>', opts)

-- lspsaga
-- u.map('n', '<c-j>', ':Lspsaga diagnostic_jump_next<CR>', opts)
u.map('n', 'K', ':Lspsaga hover_doc<CR>', opts)
u.map('n', 'gh', ':Lspsaga lsp_finder<CR>', opts)
u.map('n', '<space>ca', ':Lspsaga code_action<CR>', opts)
u.map('v', '<space>ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<CR>', opts)
u.map('n', '<c-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', opts)
u.map('n', '<c-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', opts)
u.map('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>', opts)
u.map('n', '<space>rn', '<cmd>lua require(\'lspsaga.rename\').rename()<CR> ', opts)
u.map('n', 'gp', ':Lspsaga preview_definition<CR>', opts)
u.map('n', '<space>d', ':Lspsaga show_line_diagnostics<CR>', opts)
u.map('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>', opts)
u.map('n', ']d', ':Lspsaga diagnostic_jump_next<CR>', opts)
-- u.map('n', '<leader>t', ':Lspsaga open_floaterm<CR>', opts)
-- u.map('t', '<leader>t', '<C-d><C-\\><C-n>:Lspsaga close_floaterm<CR>', opts)

-- lsp
u.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
u.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
u.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
u.map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
u.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
u.map('n', '<leader>f', ':lua vim.lsp.buf.formatting()<CR>', opts)
u.map('n', '<space>lI', ':LspInstallInfo<CR>', opts)
u.map('n', '<space>li', ':LspInfo<CR>', opts)
u.map('n', '<space>lr', ':LspRestart<CR>', opts)
u.map('n', '<space>ls', ':LspStop ', {noremap = true})

-- ctrlp, clear cache and show file path
u.map('n', '<leader>r', ':CtrlPClearCache<cr>1<c-g>', {noremap = true})

-- maximizer
u.map('n', '<space>m', ':MaximizerToggle<CR>', opts)

-- choosewin
-- u.map('n', '<space>w', ':ChooseWin<CR>', opts)

-- vim-fugitive
u.map('n', '<space>gs', ':G<CR>', opts)
u.map('n', '<space>gS', ':G switch ', {noremap = true})
u.map('n', '<space>gf', ':G fetch<CR>', opts) -- TODO: add prune
u.map('n', '<space>gp', ':G push<CR>', opts)
u.map('n', '<space>gP', ':G pull<CR>', opts)
u.map('n', '<space>gl', ':G log --decorate<CR>', opts)
u.map('n', '<space>gL', ':G log --decorate -p<CR>', opts)
u.map('n', '<space>gc', ':G commit<CR>', opts)
u.map('n', '<space>gC', ':G commit --amend<CR>', opts)
u.map('n', '<space>gd', ':Gvdiffsplit<CR>', opts)
u.map('n', '<space>gb', ':G blame<CR>', opts)
-- git related telescope
u.map('n', ';gb', ':Telescope git_branches<CR>', opts)

-- gitsigns
u.map('n', ']s', ':Gitsigns next_hunk<CR>', opts)
u.map('n', '[s', ':Gitsigns prev_hunk<CR>', opts)
u.map('n', '<space>sp', ':Gitsigns preview_hunk<CR>', opts)
u.map('n', '<space>sr', ':Gitsigns reset_hunk<CR>', opts)
u.map('n', '<space>sb', ':Gitsigns blame_line<CR>', opts)
u.map('n', '<space>st', ':Gitsigns toggle_current_line_blame<CR>', opts)
u.map('n', '<space>sd', ':Gitsigns toggle_deleted<CR>', opts)

-- toggleterm: the rest is in the lua file
u.map('n', '<space>tv', ':ToggleTerm size=80 direction=vertical<CR>', opts)
u.map('n', '<space>tf', ':ToggleTerm size=160 direction=float<CR>', opts)
-- }}}
