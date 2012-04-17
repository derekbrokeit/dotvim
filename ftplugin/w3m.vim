" This is for the w3m INSIDE vim!!
" https://github.com/yuratomo/w3m.vim
" setlocal nocursorline "cursorline required to continuously update cursor position
setlocal nocursorline
" highlight CursorLine ctermbg=238

" Default Keymaps
" <CR> Open link under the cursor.
" <S-CR> Open link under the cursor (with new tab).
" <TAB> Move cursor next link.
" <s-TAB> Move cursor previous link.
" <Space> Scroll down.
" <S-Space> Scroll up.
" <BS> Back page.
" <A-LEFT> Back page.
" <A-RIGHT> Forward page.
" = Show href under the cursor.
" f Hit-A-Hint.
" s Toggle Syntax On/Off.
" c Toggle Cookie On/Off.
" <M-D> Edit current url.

" personal keymaps
nmap <buffer><C-n>       <Plug>(w3m-next-link)
nmap <buffer><C-p>     <Plug>(w3m-prev-link)
nmap <buffer><space>       <Plug>(w3m-address-bar)
nmap <buffer><C-t>      <Plug>(w3m-shift-click)

" return my arrow keys
nmap <up> k
nmap <down> j
nmap <left> h
nmap <right> l

" history
nmap <leader>h :W3mHistory<CR>

" address
nmap <leader>c :W3mAddressBar<CR>

" reload
nmap <leader>r :W3mReload<CR>

" external browser
nmap m :W3mShowExtenalBrowser<CR>
