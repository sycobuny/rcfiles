""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" project-vimrc - Load custom vimrc files for each git project
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this is just locally-scoped shorthand so we don't have to keep writing
" out the full path
let s:proj = g:myVim.project

" file-scoped function storage space
let s:funcs = {}

" load one of the vimrc files, though we don't care which one
function s:funcs.LoadGenericVimrc(path)
    " construct a command to eval via execute later
    let s:load = 'source ' . a:path

    " if we can read the vimrc, then read it (and load it)!
    if filereadable(a:path)
        execute s:load
    endif
endfunction

function s:proj.LocalVimrc()
    return s:proj.root . '.git/vimrc'
endfunction

function s:proj.ProjectVimrc()
    return s:proj.root . '.vimrc'
endfunction

function s:proj.LoadLocalVimrc()
    call s:funcs.LoadGenericVimrc(s:proj.LocalVimrc())
endfunction

function s:proj.LoadProjectVimrc()
    call s:funcs.LoadGenericVimrc(s:proj.ProjectVimrc())
endfunction

call s:proj.LoadLocalVimrc()
call s:proj.LoadProjectVimrc()
