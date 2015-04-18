" this is the list of places we *don't* want to try to load a
" directory-specific .vimrc file
let s:no_directory_vimrc = []

" skip the home directory's .vimrc, since that is the global vimrc, which
" loads itself
call add(s:no_directory_vimrc, $HOME)

" skip a project-specific .vimrc, as projects.vim (and friends) will load it
" for us later; note we have to get the path to this ourselves, as
" projects.vim will not have loaded yet
let s:project_root = system('git root')
if !v:shell_error
    call add(s:no_directory_vimrc, s:project_root[0:-1])
endif

" try to fetch our current working directory to see if we can find a .vimrc
let s:cwd = system('pwd')
if !v:shell_error
    let s:cwd   = s:cwd[0:-2]
    let s:vimrc = s:cwd . '/.vimrc'
    let s:load  = 'source ' . s:vimrc

    " if the cwd isn't one we're skipping, and the current vimrc exists and is
    " readable, load it!
    if index(s:no_directory_vimrc, s:cwd) < 0 && filereadable(s:vimrc)
        execute s:load
    endif
endif
