" :mapclear <buffer>

let g:netrw_usexterm = 0

" let s:treedepthstring     = "│ "
" let g:netrw_hide = 1
" let g:netrw_altv=1
setlocal noconfirm
if g:NetrwIsOpen == 1
  silent! nnoremap <silent> <buffer> <nowait> q :silent q<CR>
  silent! nnoremap <silent> <buffer> <nowait> <c-c> :silent q<CR>
  silent! nnoremap <silent> <buffer> <nowait> ;q :silent q<CR>
  silent! nnoremap <silent> <buffer> <nowait> ;; :silent q<CR>
  silent! nnoremap <silent> <buffer> <nowait> ;n :silent q<CR>
  setl bufhidden=wipe
endif

nmap <buffer> <c-p> p
nmap <buffer> <c-v> v
nmap <buffer> <C-h> o<c-w>J
nmap <buffer> <C-t> t
nmap <buffer> g? <f1><silent>
nmap <buffer> gs s
nmap <buffer> g. gh
nmap <buffer> dd D
" Go back in history
nmap <buffer> H u
" Go up a directory
nmap <buffer> h -^
nmap <buffer> l <CR>
nmap <buffer> gx x

nnoremap <silent> <buffer> a :call CreateFileCloseNetrwAndEdit()<CR>

function! CreateFileCloseNetrwAndEdit()
  let dir = getreg('m')
  if empty(dir)
    " echoerr 'Register m is empty'
    let dir = getcwd()
    return
  endif

  if dir[-1:] !=# '/'
    let dir .= '/'
  endif

  let filename = input('Enter filename: ', dir, 'file')
  if empty(filename)
    return
  endif

  " Check if file exists
  if filereadable(filename) || isdirectory(filename)
    echoerr 'File or directory "' . filename . '" already exists! Aborting to prevent overwrite.'
    return
  endif


  " TODO: compare the filename with the content of the register m, if it has
  " any directories added to it, first create those directories (using call
  " mkdir, 'p'), then check the filename again and see if the last part is a
  " new filename, if yes, then create that file at the specified new location,
  " quit netrw and open (edit) the newly created file.

  if filename[-1:] ==# '/'
    try
      call mkdir(filename, 'p')
      quit
      return
    catch /.*/
      echoerr 'Could not create file: ' . v:exception
      return
    endtry
  endif

  " Create empty file
  try
    " TODO: create directories recursively
    call writefile([], filename, 's')
  catch /.*/
    echoerr 'Could not create file: ' . v:exception
    return
  endtry

  " Close netrw window
  quit

  " Edit the newly created file in the current window
  execute 'edit ' . fnameescape(filename)
endfunction
