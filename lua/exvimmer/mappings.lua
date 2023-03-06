local opts = { noremap = true, silent = true }

-- TODO: map all remaps to which-key

-- MAPPINGS {{{
-- ---------------------------------------------------------------------

-- use Telescope spell_suggest instead of the default one
vim.keymap.set("n", "z=", "<cmd>silent Telescope spell_suggest<CR>", opts)

-- run prettier in the current directory
-- vim.keymap.set('n', '<leader>P',
--   ':silent !cd ' .. utils.get_top_level() ..
--   '&& prettier --ignore-path .gitignore -w .<CR>', opts)
-- vim.keymap.set('n', '<leader>p', ':silent !prettier --ignore-path .gitignore -w %<CR>',
--   opts)

-- close and open the file again
-- vim.keymap.set('n', '<leader>r', ':bd<CR><c-o>', opts)

-- next and previous buffer
-- vim.keymap.set("n", "[b", ":bprev<CR>", opts)
-- vim.keymap.set("n", "]b", ":bnext<CR>", opts)

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
