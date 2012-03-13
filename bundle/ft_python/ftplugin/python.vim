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
"

" --- IPython bindings remapped
" nmap <silent><buffer> <leader>r :python run_this_file()<CR>
" map <silent><buffer> <F5> :python run_these_lines()<CR>
" map <silent><buffer> <F4> :python dedent_run_this_line()<CR>
" nmap <silent><buffer> <leader>d :py get_doc_buffer()<CR>
"" Example of how to quickly clear the current plot with a keystroke
"map <silent> <F12> :python run_command("plt.clf()")<cr>
"" Example of how to quickly close all figures with a keystroke
"map <silent> <F11> :python run_command("plt.close('all')")<cr>

"pi custom
" nmap <silent> <C-Return> :python run_this_file()<CR>
" imap <silent> <C-s> <esc>:w<CR>:python run_this_line()<CR>
" nmap <silent> <M-s> :python dedent_run_this_line()<CR>
" vmap <silent> <C-S> :python run_these_lines()<CR>
" vmap <silent> <M-s> :python dedent_run_these_lines()<CR>
