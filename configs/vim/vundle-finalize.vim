""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle-finalize.vim - finish Vundle config with post-plugin instructions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !g:myVim.vundle.compat
    " new Vundle needs this call to happen
    call vundle#end()
endif

" both old and new Vundle require turning this off during setup, but I want
" filetype detection, so I'm turning it back on.
filetype plugin indent on
