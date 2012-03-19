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


" for now, I am disabling conceal, uncertain if I should simply uninstall the
" cute unicode submodule

if version >= 703 
  setlocal conceallevel=0 
endif 

" setlocal tags+=~/.vim/ctags/py_matplotlib
"

" turn off ipython mappings
let g:ipy_perform_mappings=0
" --- IPython bindings remapped
map <silent><buffer> <leader>R :w<CR>:python run_this_file()<CR>
map <silent><buffer> <leader>r :w<CR>:python dedent_run_these_line()<CR>
nmap <silent><buffer> <leader>d :py get_doc_buffer()<CR>

vmap <silent><buffer> <C-S> :w<CR>:python run_these_lines()<CR>
" vmap <silent><buffer> <leader>r python dedent_run_these_lines()<CR>
"" Example of how to quickly clear the current plot with a keystroke
"map <silent> <F12> :python run_command("plt.clf()")<cr>
"" Example of how to quickly close all figures with a keystroke
"map <silent> <F11> :python run_command("plt.close('all')")<cr>

"pi custom
" nmap <silent> <C-Return> :python run_this_file()<CR>
imap <silent> <C-s> <esc>:w<CR>:python run_this_line()<CR>
" nmap <silent> <M-s> :python dedent_run_this_line()<CR>
" vmap <silent> <C-S> :python run_these_lines()<CR>
" vmap <silent> <M-s> :python dedent_run_these_lines()<CR>
