vim.cmd([[
  " let g:vimspector_base_dir=expand('$HOME/.config/vimspector-config')
  let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools', 'CodeLLDB', 'delve']
  " let g:vimspector_enable_mappings = 'HUMAN'
  let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
  nnoremap <space>dl :call vimspector#Launch()<CR>
  nnoremap <space>dr :call vimspector#Reset()<CR>
  nnoremap <space>dR :call vimspector#Restart()<CR>
  nnoremap <space>di :call vimspector#StepInto()<CR>
  nnoremap <space>do :call vimspector#StepOver()<CR>
  nnoremap <space>dO :call vimspector#StepOut()<CR>
  nnoremap <space>dc :call vimspector#Continue()<CR>
  nnoremap <space>dC :call vimspector#RunToCursor()<CR>
  nnoremap <space>dt :call vimspector#ToggleBreakpoint()<CR>
  nnoremap <space>dT :call vimspector#ToggleConditionalBreakpoint()<CR>
  nnoremap <space>dx :call vimspector#ClearBreakpoints()<CR>
  nnoremap <space>dw :call AddToWatch()<CR>
  vmap <space>db <Plug>VimspectorBalloonEval
  nmap <space>db <Plug>VimspectorBalloonEval
  func! AddToWatch()
    let word = expand("<cexpr>")
    call vimspector#AddWatch(word)
  endfunction
]])
