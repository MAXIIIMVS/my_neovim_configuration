local u = require('utils')
local cmd = vim.cmd
-- MAPPINGS {{{
-- ---------------------------------------------------------------------
u.map('n', '<S-Tab>', ':tabprev<CR>', {silent = true})
u.map('n', '<Tab>', ':tabnext<CR>', {silent = true})

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
u.map('n', '[t', 'gT', {noremap = true, silent = true})
u.map('n', ']t', 'gt', {noremap = true, silent = true})

-- Switch between windows
u.map('n', '<c-j>', '<c-w>j', {noremap = true})
u.map('n', '<c-k>', '<c-w>k', {noremap = true}) -- NOTE: you need something else for signature
u.map('n', '<c-l>', '<c-w>l', {noremap = true})
u.map('n', '<c-h>', '<c-w>h', {noremap = true})

-- next and previous buffer
u.map('n', '[b', ':bprev<CR>', {noremap = true, silent = true})
u.map('n', ']b', ':bnext<CR>', {noremap = true, silent = true})

-- delete all buffers other than the current one, put the cursor back
-- nnoremap <space>bo :%bd\|e#\|bd#<CR>\|'"
u.map('n', '<space>bo', ':%bd|e#|bd#<CR>|\'"', {noremap = true})

-- delete all buffers
-- nnoremap <space>ba :bufdo bd<CR>
u.map('n', '<space>ba', ':bufdo bd<CR>')

-- map ^a, ^e, ^k and ^t in insert mode to act like they do in terminal
u.map('i', '<c-a>', '<c-o>I', {noremap = true})
u.map('i', '<c-e>', '<c-o>A', {noremap = true})
u.map('i', '<c-k>', '<c-o>C', {noremap = true})
u.map('i', '<c-t>', '<Esc>x<Esc>gepa<c-d>', {noremap = true})
u.map('i', '<c-f>', '<RIGHT>', {noremap = true})
u.map('i', '<c-b>', '<LEFT>', {noremap = true})

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

-- toggle nvim-tree
u.map('n', '<space>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- telescope
-- TODO: remove useless mappings after a while
u.map('n', ';f', ':Telescope find_files<CR>', {noremap = true, silent = true})
u.map('n', ';r', ':Telescope live_grep<CR>', {noremap = true, silent = true})
u.map('n', ';h', ':Telescope help_tags<CR>', {noremap = true, silent = true})
u.map('n', ';c', ':Telescope commands<CR>', {noremap = true, silent = true})
u.map('n', ';C', ':Telescope colorscheme<CR>', {noremap = true, silent = true})
u.map('n', ';lr', ':Telescope lsp_references<CR>', {noremap = true, silent = true})
u.map('n', ';lca', ':Telescope lsp_code_actions<CR>', {noremap = true, silent = true})
u.map('n', ';le', ':Telescope diagnostics<CR>', {noremap = true, silent = true})
u.map('n', ';ld', ':Telescope lsp_definitions<CR>', {noremap = true, silent = true})
u.map('n', ';lt', ':Telescope lsp_definitions<CR>', {noremap = true, silent = true})
u.map('n', ';gc', ':Telescope git_commits<CR>', {noremap = true, silent = true})
u.map('n', ';gs', ':Telescope git_status<CR>', {noremap = true, silent = true})
u.map('n', ';qf', ':Telescope quickfix<CR>', {noremap = true, silent = true})
u.map('n', ';b', ':Telescope buffers<CR>', {noremap = true, silent = true})
u.map('n', ';t', ':Telescope tags<CR>', {noremap = true, silent = true})
u.map('n', ';s', ':Telescope search_history<CR>', {noremap = true, silent = true})
u.map('n', ';m', ':Telescope marks<CR>', {noremap = true, silent = true})
u.map('n', ';R', ':Telescope registers<CR>', {noremap = true, silent = true})
-- }}}
