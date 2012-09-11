
" coloring for notetaking with @* character
syn match Identifier /\v\@\w+/
syn match Copyright /\v^Copyright.*/
 
" underline the current line
nmap <buffer> _u yypVr-
nmap <buffer> _U yypVr=

" add horizontal rule
nmap <buffer> _h     o<esc>030i*<space><esc>

" blockquote
nmap <buffer> _b vip<C-V>I><space><esc>


" markdown related highlighting
hi markdownCode ctermfg=4           guifg=#f2d517
hi markdownCodeBlock ctermfg=4      guifg=#f2d517
hi Copyright guifg=#2baa9c
