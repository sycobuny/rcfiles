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

" remap ]], [[, [], and ][ to find block encoding without C-style
" yoinked from vim help, see :help object-motions
nnoremap [[ ?{<CR>w99[{
nnoremap ][ /}<CR>b00]}
nnoremap ]] j0[[%/{<CR>
nnoremap [] k$][%?}<CR>

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

"""""""""""""
" VISUAL MODE
"""""""""""""

" \r - send commands using posgres using <Leader>r
" idea from Depesz, http://postgr.es/p/1DH
" slightly modified to dump into register r instead of the buffer
vnoremap <Leader>r :\|let @r = system('psql -t', VS())<enter>

" \i - break lines around a visual selection
vnoremap <Leader>i <Esc>a<CR><Esc>gvo<Esc>i<CR><Esc>

""""""""""""""""""""""""""""""""""""""""""""
" POLY MODE (NORMAL/VISUAL/OPERATOR-PENDING)
""""""""""""""""""""""""""""""""""""""""""""

" learn vim the hard way - disable arrow movement
noremap  <Up>    <NOP>
noremap  <Down>  <NOP>
noremap  <Left>  <NOP>
noremap  <Right> <NOP>
