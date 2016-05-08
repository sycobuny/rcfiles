"""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings.vim - (re)mappings of common Vim behaviors
"""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""
" GENERAL SETTINGS
""""""""""""""""""

" change the <Leader> to spacebar instead of \ (the default)
let mapleader = ' '

"""""""""""""
" NORMAL MODE
"""""""""""""

" <Space>rc - reload the ~/.vimrc file
nnoremap <Leader>rc :source $MYVIMRC<CR>

" <Space>p - switch into and out of paste mode easily
nnoremap <Leader>p :set paste!<Enter>

" <Space>^S - save current work to a remote WIP branch \^S
nnoremap <Leader><C-s> :Git wip<CR>

" <Space>^L - load remote WIP branch into current working copy
nnoremap <Leader><C-l> :Git wip-restore<CR>

" <Space>c - Clear color column settings
nnoremap <Leader>c :call g:myVim.DisableColorColumn()<CR>

" <Space>C - Enable color column settings
nnoremap <Leader>C :call g:myVim.EnableColorColumn()<CR>

" <Space><Space> - clear highlights quickly
nnoremap <Leader><Space> :noh<CR>

"""""""""""""
" VISUAL MODE
"""""""""""""
" NB: : auto-maps to :'<'> in visual mode

" ;' - Swap " to ' inside the current selection
vnoremap <Leader>' :s/"/'/g<CR>

"""""""""""""
" INSERT MODE
"""""""""""""

" remap jk to exit insert mode, and leave the cursor where it was before
" note that this, like any other insert mode mappings, is disabled if you've
" enabled paste mode
inoremap jk <C-c>`^
