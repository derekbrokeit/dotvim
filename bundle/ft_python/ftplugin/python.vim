" From: http://vim.wikia.com/wiki/Keep_your_vimrc_file_clean
" File ~/.vim/ftplugin/python.vim
" ($HOME/vimfiles/ftplugin/python.vim on Windows)
" Python specific settings.
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal formatoptions=croql

command! -nargs=0 Runpy !python %
nmap <buffer> <leader>r :w<CR>:!python %<CR>
nmap <buffer> <leader>R :w<CR>:!ipython %<CR>

" setlocal tags+=~/.vim/ctags/py_matplotlib
