
" coloring for notetaking with @* character
syn match Identifier /\v\@\w+/
 
" underline the current line
nmap <buffer> _u yypVr-
nmap <buffer> _U yypVr=

" add horizontal rule
nmap <buffer> _h     o<esc>030i*<space><esc>

" blockquote
nmap <buffer> _b vip<C-V>I><space><esc>


