" make fullscreen
if os == "Darwin"
    set fu
    set guifont=Anonymous\ Pro:h11
    set antialias
else
    set guifont=Anonymous\ Pro\ 11
    set noantialias
endif

" remove the menubar, tab-bar, and left/right scrollareas
set guioptions=gt

" better fonts
" antialiasing appears to be necessary for some bold/italic effects to always
" work. otherwise, they work sometimes at some sizes and then begin to fail in
" macvim for unkown reasons
" set noantialias

" better motion
nnoremap <D-k> <C-W>k
nnoremap <D-j> <C-W>j
nnoremap <D-h> <C-W>h
nnoremap <D-l> <C-W>l

nnoremap <D-up> <C-W><up>
nnoremap <D-down> <C-W><down>
nnoremap <D-left> <C-W><left>
nnoremap <D-right> <C-W><right>

" fix the ¥ char
" nmap \¥ \\
