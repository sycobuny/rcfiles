"""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings.vim - (re)mappings of common Vim behaviors
"""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""
" NORMAL MODE
"""""""""""""

" \rc - reload the ~/.vimrc file
nnoremap <Leader>rc :source $MYVIMRC<CR>

" \p - switch into and out of paste mode easily
nnoremap <Leader>p :set paste!<Enter>

" \^S - save current work to a remote WIP branch \^S
nnoremap <Leader><C-s> :Git wip<CR>

" \^L - load remote WIP branch into current working copy
nnoremap <Leader><C-l> :Git wip-restore<CR>

" \  - clear highlights quickly
nnoremap <Leader><Space> :noh<CR>

"""""""""""""
" INSERT MODE
"""""""""""""

" remap jk to exit insert mode, and leave the cursor where it was before
" note that this, like any other insert mode mappings, is disabled if you've
" enabled paste mode
inoremap jk <C-c>`^

" learn vim the hard way - disable arrow movement
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

""""""""""""""""""""""""""""""""""""""""""""
" POLY MODE (NORMAL/VISUAL/OPERATOR-PENDING)
""""""""""""""""""""""""""""""""""""""""""""

" learn vim the hard way - disable arrow movement
noremap  <Up>    <NOP>
noremap  <Down>  <NOP>
noremap  <Left>  <NOP>
noremap  <Right> <NOP>
