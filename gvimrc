" make fullscreen
if os == "Darwin"
    set fu
    set guifont=Anonymous\ Pro\ for\ Powerline:h11
    set antialias
else
    set guifont=Anonymous\ Pro\ 11
    set noantialias
endif

" remove the menubar, tab-bar, and left/right scrollareas
set guioptions=gt

" turn off bells (auditory and visual)
set vb

" better fonts
" antialiasing appears to be necessary for some bold/italic effects to always
" work. otherwise, they work sometimes at some sizes and then begin to fail in
" macvim for unkown reasons
" set noantialias

" better motion
map <D-k> <esc><C-W>k
map <D-j> <esc><C-W>j
map <D-h> <esc><C-W>h
map <D-l> <esc><C-W>l

map <D-up>    <esc><C-W><up>
map <D-down>  <esc><C-W><down>
map <D-left>  <esc><C-W><left>
map <D-right> <esc><C-W><right>

" better split creation
map <C-S-left>          <esc>:topleft  vnew <CR>
map <C-S-right>         <esc>:botright vnew <CR>
map <C-S-up>            <esc>:topleft  new <CR>
map <C-S-down>          <esc>:botright new <CR>
" buffer
map <D-S-left>          <esc>:leftabove  vnew <CR>
map <D-S-right>         <esc>:rightbelow vnew <CR>
map <D-S-up>            <esc>:leftabove  new <CR>
map <D-S-down>          <esc>:rightbelow new <CR>
" more splitting
"map <D-|> <D-S-right>
"map <D>- <D-S-down>

" fix the ¥ char
" nmap \¥ \\

" expanding and equalizing buffers
map <D-_> <esc><C-W>_<C-W><Bar>
map <D-/> <esc><C-W>=

