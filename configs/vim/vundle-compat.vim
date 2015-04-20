""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle-compat.vim - setup Vundle, w/easing for old Vundle versions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up generic required Vundle settings for all versions
set      nocompatible " this should generally be off anyway, but whatever
filetype off          " not sure why, but I follow directions.

" scope some variables we can use for reference later, and add a shorthand way
" to reference them
let g:myVim.vundle.compat = {}
let s:compat = g:myVim.vundle.compat

" determine whether or not we're using an old edition of Vundle, and behave
" appropriately.
if isdirectory(g:myVim.vundle.path)
    let s:compat.path   = 'set rtp+=' . g:myVim.vundle.path
    let s:compat.plugin = 'Plugin "'  . g:myVim.vundle.plugin . '"'
else
    let s:compat.path   = 'set rtp+=' . g:myVim.vundle.path_compat
    let s:compat.plugin = 'Bundle "'  . g:myVim.vundle.plugin_compat . '"'
endif

" include the path to Vundle, wherever that is
execute s:compat.path

" figure out how to get a tune out of this trombone
if exists('&vundle#begin')
    " since #begin() exists, we'll just use that to start up Vundle
    let s:compat.Begin    = function('vundle#begin')

    " if we have #begin(), we'll need to call #end() to actually get plugins
    let s:compat.finalize = 1
else
    " instead, we use #rc(), which immediately does everything
    let s:compat.Begin = function('vundle#rc')

    " if there's no #begin(), there's no #end()
    let s:compat.finalize = 0
endif

" start up Vundle, and have it manage itself
call    s:compat.Begin()
execute s:compat.plugin

" set up an alias for a few 'Plugin' commands that I use so I can mimic having
" the new version of Vundle in the rc files, even when I don't, really.
if !exists(':Plugin')
    " save that we're just wrapping Bundle with a compatibility layer
    let s:compat.wrapper_commands = 1

    " this is the most important one - it's what the rc files use to install
    " plugins, so it needs to exist or the rc files will fail to load with
    " *lots* of error messages
    command -nargs=+ Plugin Bundle <args>

    " I'm not going to worry about the autocompletion because I never use that
    command -nargs=? PluginInstall BundleInstall<bang> <args>
    command -nargs=0 PluginUpdate  BundleUpdate
else
    " save that we're not using a command-wrapping compatibility layer
    let s:compat.wrapper_commands = 0
endif
