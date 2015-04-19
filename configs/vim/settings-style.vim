""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings-style.vim - editor style and code auto-stying
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""
" EDITOR STYLE
""""""""""""""
set number     " display line numbers
set cursorline " display highlighting on the active line
set nopaste    " never start in paste mode
set t_Co=256   " assume 256-color capability
syntax enable  " use syntax highlighting

" add overflow column warning coloring - if we can. either we'll use the very
" nice colorcolumn var provided in 7.3, or matchadd which was introduced in
" 7.1 in later patches and solidly exists in 7.2. if neither exists, we just
" don't bother.
if exists('+colorcolumn')
    set colorcolumn=79
elseif exists('*matchadd')
    " note that before I was saving this into a w:m2 variable per the Vim Tips
    " wiki entry, but that was so that I could clear it later if I wanted; I
    " never wrote a mechanism for doing this, though, so I'm not bothering to
    " save it anymore, at least until I write such a method.
    autocmd BufWinEnter * call matchadd('ErrorMsg', '\%>79v.\+', -1)
endif

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
