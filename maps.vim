" Description: Keymaps

" Delete a word backwards
" nnoremap dw vb"_d

" Select all
nmap <C-a> gg<S-v>G

" Save with root permission
command! W w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
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

"-----------------------------
" Tabs

" Open current directory
nmap te :tabedit
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

"------------------------------
" Windows

" Split window
" nmap ss :split<Return><C-w>w
" nmap sv :vsplit<Return><C-w>w
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

" MAPPINGS {{{
" ---------------------------------------------------------------------
"insert a blank line around the cursor
map ]<space> o<ESC>k
map [<space> O<ESC>j

" vimgrep next and previous occurance
nnoremap <silent> [g :cprev<CR>
nnoremap <silent> ]g :cnext<CR>

" Go to the next or previous tab
nnoremap <silent>[t gT
nnoremap <silent>]t gt

" Switch between windows
nnoremap <space>j <c-w>j
nnoremap <space>k <c-w>k
nnoremap <space>l <c-w>l
nnoremap <space>h <c-w>h

" launch terminal
" nnoremap <leader>t :terminal<CR>i

" next and previous buffer
nnoremap <silent> [b :bprev<CR>
nnoremap <silent> ]b :bnext<CR>

" delete all buffers other than the current one, put the cursor back
nnoremap <space>bo :%bd\|e#\|bd#<CR>\|'"

" delete all buffers
nnoremap <space>ba :bufdo bd<CR>

" map ^a, ^e, ^k and ^t in insert mode to act like they do in terminal
inoremap <c-a> <c-o>I
inoremap <c-e> <c-o>A
inoremap <c-k> <c-o>C
inoremap <c-t> <Esc>x<Esc>gepa<c-d>
" NOTE: I don't add space back (unlike terminal) on purpose.
inoremap <c-f> <RIGHT>
inoremap <c-b> <LEFT>

" Enter -> :noh
nnoremap <CR> :noh<CR><CR>

" Ctrl+s -> :w
nnoremap <c-s> :w<CR>
inoremap <c-s> <ESC>:w<CR>
vnoremap <c-s> <ESC>:w<CR>

" Delete the characer after cursor
inoremap <C-d> <Del>

" make . to work with visually selected lines
vnoremap . :normal.<CR>

" Move visual selection
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

" search the visually selected text
" vnoremap * y/<c-r>0<CR>
" vnoremap # y?<c-r>0<CR>
" vnoremap * yq/p<CR>

" repeat the last command
nnoremap <space>. :<UP><CR>
" }}}
