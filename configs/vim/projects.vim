" initialize project-specific settings
let g:myVim.project = {}

" directory for the project (using the 'git root' alias from the ~/.gitconfig
" file)
let s:project_root = system('git root')

" test if we got a valid value from `git root`. if not, we're not actually
" inside a project, and we should bail out (and let other scripts know to bail
" too). otherwise, set a variable to store this information for later.
if v:shell_error
    let g:myVim.project.active = 0
else
    let g:myVim.project.active = 1
    let g:myVim.project.root   = s:project_root[0:-2] . '/'

    " load project-specific scripts
    call g:myVim.LoadScript('project-vimrc')    " project-local .vimrc files
    call g:myVim.LoadScript('project-sessions') " project-local sessions
endif
