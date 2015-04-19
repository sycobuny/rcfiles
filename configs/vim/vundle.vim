"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle.vim - set up and load vundle and related plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" prepare to load Vundle - load paths, check availability
call g:myVim.LoadScript('vundle-init')

" only try to set up vundle for real if it actually exists on the system
if g:myVim.vundle.available
    call g:myVim.LoadScript('vundle-compat')
    call g:myVim.LoadScript('vundle-plugins')
    call g:myVim.LoadScript('vundle-finalize')
endif
