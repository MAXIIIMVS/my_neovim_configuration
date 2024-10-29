" :mapclear <buffer>

let g:netrw_usexterm = 0

" let s:treedepthstring     = "│ "
" let g:netrw_hide = 1
" let g:netrw_altv=1
silent! nnoremap <buffer> <nowait> q :silent q<CR><silent>
silent! nnoremap <buffer> <nowait> <c-c> :silent q<CR><silent>
silent! nnoremap <buffer> <nowait> ;q :silent q<CR><silent>
silent! nnoremap <buffer> <nowait> ;; :silent q<CR><silent>
silent! nnoremap <buffer> <nowait> ;n :silent q<CR><silent>
setl bufhidden=wipe

nmap <buffer> <c-p> p
nmap <buffer> <c-v> v
nmap <buffer> <C-t> t
nmap <buffer> g? <f1><silent>
nmap <buffer> gs s
nmap <buffer> g. gh
" Go back in history
nmap <buffer> H u
" Go up a directory
nmap <buffer> h -^
nmap <buffer> l <CR>
nmap <buffer> gx x
