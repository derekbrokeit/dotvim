" coloring for notetaking with @* character
syn match Identifier /\v\@\w+/

" copyright info
syn match Copyright /\v^Copyright.*/

" this is the jinja2 syntax 
syn region markdownCode matchgroup=markdownCodeDelimiter start="^\s*\zs{%.*syntax.*$" end="{%.*endsyntax.*%}\ze\s*$"

" this is '~~~python' type syntax
syn region markdownCode matchgroup=markdownCodeDelimiter start="^\s*\zs\~\~\~.*$" end="^\~\~\~\ze\s*$" 

" mathjax syntax
syn region javaScriptNumber start="\$" end="\$"
syn region javaScriptNumber start="\$\$" end="\$\$"

" markdown related highlighting
hi markdownCode ctermfg=4           guifg=#f2d517
hi markdownCodeBlock ctermfg=4      guifg=#f2d517
hi Copyright ctermfg=red guifg=#2baa9c
