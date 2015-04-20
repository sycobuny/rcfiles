""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle-finalize.vim - finish Vundle config with post-plugin instructions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if g:myVim.vundle.compat.finalize
    " new Vundle needs this call to happen so that it will actually fully load
    " the paths to the various plugins and thus enable them
    call vundle#end()
endif

" both old and new Vundle require turning this off during setup, but I want
" filetype detection, naturally, so I turn it back on, per instructions.
filetype plugin indent on
