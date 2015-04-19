""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle-compat.vim - setup Vundle, w/easing for old Vundle versions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up generic required Vundle settings for all versions
set      nocompatible " this should generally be off anyway, but whatever
filetype off          " not sure why, but I follow directions.

" determine whether or not we're using an old edition of Vundle, and behave
" appropriately.
if isdirectory(g:myVim.vundle.path)
    " no need to set up special aliases for compatibility; we're already
    " upgraded
    let g:myVim.vundle.compat = 0

    " include the path to Vundle
    let s:add_path = 'set rtp+=' . g:myVim.vundle.path
    execute s:add_path

    " have Vundle finish setting itself up
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
else
    " we don't have the new directory, so let's assume we've got the old one,
    " and set up compatibility mode
    let g:myVim.vundle.compat = 1

    " include the path to Vundle
    let s:add_path = 'set rtp+=' . g:myVim.vundle.path_compat
    execute s:add_path

    " have Vundle finish setting itself up
    call vundle#rc()
    Bundle 'gmarik/vundle'

    " set up an alias for the 'Plugin' command so we can mimic having the new
    " Vundle in the rc files, even when we don't
    command -nargs=+ Plugin Bundle <args>

    " set up aliases for 'BundleInstall' and 'BundleUpdate' (the only two
    " commands I personally use) as well, so I can get used to the new
    " Vundle names - I'm not going to worry about the autocompletion because I
    " never use that.
    command -nargs=? PluginInstall BundleInstall<bang> <args>
    command -nargs=0 PluginUpdate  BundleUpdate
endif
