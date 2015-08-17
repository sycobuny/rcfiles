""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings-style.vim - editor style and code auto-stying
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""
" EDITOR STYLE
""""""""""""""
set number           " display line numbers
set cursorline       " display highlighting on the active line
set nopaste          " never start in paste mode
set t_Co=256         " assume 256-color capability
set background=light " guarantee light backgrounds for PaperColor
syntax enable        " use syntax highlighting

" add overflow column warning coloring - if we can. either we'll use the very
" nice colorcolumn var provided in 7.3, or matchadd which was introduced in
" 7.1 in later patches and solidly exists in 7.2. if neither exists, we just
" don't bother.
function g:myVim.EnableColorColumn()
    if !exists('b:maxTextWidth')
        let b:maxTextWidth = 79
    endif

    if exists('+colorcolumn')
        let l:eval = 'setlocal colorcolumn=' . b:maxTextWidth
        exec l:eval
    elseif exists('*matchadd')
        " don't add another colorcolumn on top of what we've already got
        if !exists('w:colorColumn')
            let l:match = '\%>' . b:maxTextWidth . 'v.\+'
            let w:colorColumn = matchadd('ErrorMsg', l:match, -1)
        endif
    endif
endfunction

" remove overflow column warning coloring if it was able to be set
function g:myVim.DisableColorColumn()
    if exists('+colorcolumn')
        setlocal colorcolumn=0
    elseif exists('*matchadd')
        " only try to unset the colorColumn if there was one set in the first
        " place
        if exists('w:colorColumn')
            call matchdelete(w:colorColumn)
            unlet w:colorColumn
        endif
    endif
endfunction

" automatically enable color columns when opening buffers
autocmd BufWinEnter * call g:myVim.EnableColorColumn()

""""""""""""
" CODE STYLE
""""""""""""
" in theory, 'colorcolumn' sets the textwidth, but a) my preference is that
" the colorcolumn function like a border that is not written on, and b) in
" earlier versions of Vim, it won't even be used anyway, so here we manually
" say that, by default, we want 78-character rows
set textwidth=78

set smartindent  " have VIM auto-indent when possible
set tabstop=4    " tabs are 4 characters wide by default for most code
set shiftwidth=4 " indent level is also 4 characters wide by default
set expandtab    " expand tabs to spaces when I push the tab key

" allow backspacing over indents/etc. - this sort of straddles the line
" between an editor behavior and a style behavior, but I feel more like it
" falls in line with the 'smartindent' idea.
set backspace=indent,eol,start
