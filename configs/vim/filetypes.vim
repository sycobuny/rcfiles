"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetypes.vim - settings for configuring specific filetype behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""
" FILETYPE BEHAVIORS
""""""""""""""""""""
" we'll store filetype-specific behavior in a Dictionary with each language
" being a function, just so we can easily stack multiple behaviors
let g:myVim.fileTypes = {}

" help - a specific subset of text files
function g:myVim.fileTypes.help()
    " because they have so many non-English words, it's best to turn off
    " spellcheck for those files (as it will be on by default for textfiles
    set nospell
endfunction

" gitcommit - The editor state when modifying a `git commit` or `git tag`
function g:myVim.fileTypes.gitcommit()
    " git commit messages should be 72 characters wide - see:
    " http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
    " I imagine the 'fugitive' plugin handles this, but various configurations
    " by my vimrc seem to break it, so I do it again manually here.
    set textwidth=72

    " turn on spellchecking in git commit messages
    set spell
endfunction

" markdown - Lightweight formatted text
function g:myVim.fileTypes.markdown()
    set spell
endfunction

" puppet - custom language for the Puppet config management tool
function g:myVim.fileTypes.puppet()
    set shiftwidth=2
    set tabstop=2
endfunction

" snippet - custom plugin-defined language for creating auto-expansions
function g:myVim.fileTypes.snippet()
    " it uses tabs to indent the expansion sections
    set noexpandtab
endfunction

" text - Plain text files (naturally)
function g:myVim.fileTypes.text()
    set spell
endfunction

" build autocmd strings for all the file types we've prepared so far, and load
" them in
for s:ft in keys(g:myVim.fileTypes)
    let s:auto = 'autocmd FileType ' . s:ft . ' call g:myVim.fileTypes.'
    let s:auto = s:auto . s:ft . '()'

    execute s:auto
endfor

""""""""""""""""""""""""""
" CUSTOM FILETYPE MAPPINGS
""""""""""""""""""""""""""
" file patterns which no Vim default or plugin I've got auto-understands as a
" particular type
autocmd BufNewFile,BufRead,BufWrite Vagrantfile,Gemfile   set ft=ruby
autocmd BufNewFile,BufRead,BufWrite *.spreadsheet,*.prawn set ft=ruby
autocmd BufNewFile,BufRead,BufWrite cpanfile              set ft=perl
