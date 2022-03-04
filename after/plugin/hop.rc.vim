" nnoremap <space>; :HopWord<CR>
" nnoremap <space>, :HopWordMW<CR>
nnoremap <space>; :HopWordMW<CR>
nnoremap <space>/ :HopPatternMW<CR>
nnoremap <space>' :HopLineMW<CR>
" nnoremap <space>1 :HopChar1<CR>
nnoremap <space>, :HopChar1MW<CR>
nnoremap <space>2 :HopChar2MW<CR>

lua << EOF
  require'hop'.setup()
EOF
