" This is for the w3m INSIDE vim!!
" https://github.com/yuratomo/w3m.vim

" set up the line number being highlighted, but cursor line is not
" The link should be highlighted with hover-highlighting instead
" highlight CursorLine cterm=none ctermbg=none
" highlight CursorLineNr  ctermfg=yellow ctermbg=239
" setlocal cursorline "cursorline required to continuously update cursor position

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
nmap <buffer> <up> k
nmap <buffer> <down> j
nmap <buffer> <left> h
nmap <buffer> <right> l

" history
nmap <buffer><leader>h :W3mHistory<CR>

" address
nmap <buffer><leader>c :W3mAddressBar<CR>

" reload
nmap <buffer><leader>r :W3mReload<CR>

" external browser
nmap <buffer>m :W3mShowExtenalBrowser<CR>
nmap <buffer>o :W3mShowExtenalBrowser<CR>
