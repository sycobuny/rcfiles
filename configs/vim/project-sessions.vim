""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" project-sessions.vim - Load/save sessions for each git project
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this is just locally-scoped shorthand so we don't have to keep writing
" out the full path
let s:proj = g:myVim.project

function s:proj.SessionPath()
    return s:proj.root . '.git/vimsession'
endfunction

function s:proj.LoadSession()
    let l:sess = s:proj.SessionPath()
    let l:load = 'source ' . l:sess

    if filereadable(l:sess)
        execute l:load
    endif
endfunction

function s:proj.SaveSession()
    let l:save = 'mksession! ' . s:proj.SessionPath()
    execute l:save
endfunction

" only if the command-line args list is empty will we try to auto-load
" the sessions
if argc() == 0
    autocmd VimEnter * :call s:proj.LoadSession()
end

" on the other hand, we'll always try to save them. note: previous
" versions of this script (when it was all in ~/.vimrc) tried to save this
" every time a buffer was written; I'm less concerned now that we try to
" save so frequently, so it just saves on a normal Vim exit
autocmd VimLeave * :call s:proj.SaveSession()
