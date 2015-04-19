""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init.vim - core custom configuration setup/functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" since we're putting stuff in the global scope, we're going to try avoiding
" too much littering by putting it all inside a g:myVim variable. We also
" avoid overwriting any of our definitions when reloading, unless specifically
" asked to do so.
if !exists('g:myVim')
    " initialize our local vim config
    let g:myVim = {}

    " specify the directory where we expect to find our custom vimrc bits
    let g:myVim.dir = expand('<sfile>:h') . '/'

    " our loaded custom scripts
    let g:myVim.scripts = [expand('<sfile>:h:p')]

    " a function to wipe our current settings
    function g:myVim.EraseSettings()
        unlet g:myVim
    endfunction

    " a function to force-reload all of ~/.vimrc, including this file
    function g:myVim.Reload()
        call g:myVim.EraseSettings()
        source $MYVIMRC
    endfunction

    function g:myVim.FullScriptPath(script)
        return g:myVim.dir . a:script . '.vim'
    endfunction

    function g:myVim.ScriptIsLoaded(script)
        return index(g:myVim.scripts, g:myVim.FullScriptPath(a:script)) >= 0
    endfunction

    " a function to load additional script files in this directory
    function g:myVim.LoadScript(script)
        " check if the script has already been loaded
        if g:myVim.ScriptIsLoaded(a:script)
            return
        end

        " construct the path to the script, and an eval string to load it
        let l:script = g:myVim.FullScriptPath(a:script)
        let l:load   = 'source ' . l:script

        " save that we're trying to load this script. we can theoretically
        " view this with :scriptnames, but this is limited to custom ~/.vimrc
        " loaded scripts called with this function, so it's more narrow in
        " focus. we can use it to quickly make sure we're loading everything
        " in '$RCDIR/configs/vim/' - it also allows us to prevent loading the
        " same file twice
        call add(g:myVim.scripts, l:script)

        " load the script file (this has to be done via 'execute' because
        " 'source' takes its arguments as a literal
        execute l:load
    endfunction
endif
