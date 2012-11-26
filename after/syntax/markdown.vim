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

" abbreviations
syn region markdownIdDeclaration matchgroup=markdownLinkDelimiter start="^\*\[" end="\]:" oneline keepend nextgroup=markdownUrlTitle skipwhite

" jinja stuff
"syn region Comment start=+{#+ end=+#}+
"syn match htmlTag /\v\{\%\-{0,1}.*\-{0,1}\%\}/

" markdown related highlighting
hi markdownCode ctermfg=4           guifg=#f2d517
hi markdownCodeBlock ctermfg=4      guifg=#f2d517
hi Copyright ctermfg=red guifg=#2baa9c

" yaml front matter
syn include @liquidYamlTop syntax/yaml.vim
unlet! b:current_syntax
syn region liquidYamlHead start="\%^---$" end="^---\s*$" keepend contains=@liquidYamlTop,@Spell

" Jinja template built-in tags and parameters (without filter, macro, is and raw, they
" have special threatment)
syn keyword jinjaStatement containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained and if else in not or recursive as import

syn keyword jinjaStatement containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained is filter skipwhite nextgroup=jinjaFilter
syn keyword jinjaStatement containedin=jinjaTagBlock contained macro skipwhite nextgroup=jinjaFunction
syn keyword jinjaStatement containedin=jinjaTagBlock contained block skipwhite nextgroup=jinjaBlockName

" Variable Names
syn match jinjaVariable containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained skipwhite /[a-zA-Z_][a-zA-Z0-9_]*/
syn keyword jinjaSpecial containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained false true none False True None loop super caller varargs kwargs

" Filters
syn match jinjaOperator "|" containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained nextgroup=jinjaFilter
syn match jinjaFilter contained skipwhite /[a-zA-Z_][a-zA-Z0-9_]*/
syn match jinjaFunction contained skipwhite /[a-zA-Z_][a-zA-Z0-9_]*/
syn match jinjaBlockName contained skipwhite /[a-zA-Z_][a-zA-Z0-9_]*/

" Jinja template constants
syn region jinjaString containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained start=/"/ skip=/\\"/ end=/"/
syn region jinjaString containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained start=/'/ skip=/\\'/ end=/'/
syn match jinjaNumber containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained /[0-9]\+\(\.[0-9]\+\)\?/

" Operators
syn match jinjaOperator containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained /[+\-*\/<>=!,:]/
syn match jinjaPunctuation containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained /[()\[\]]/
syn match jinjaOperator containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained /\./ nextgroup=jinjaAttribute
syn match jinjaAttribute contained /[a-zA-Z_][a-zA-Z0-9_]*/

" Jinja template tag and variable blocks
syn region jinjaNested matchgroup=jinjaOperator start="(" end=")" transparent display containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained
syn region jinjaNested matchgroup=jinjaOperator start="\[" end="\]" transparent display containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained
syn region jinjaNested matchgroup=jinjaOperator start="{" end="}" transparent display containedin=jinjaVarBlock,jinjaTagBlock,jinjaNested contained
syn region jinjaTagBlock matchgroup=jinjaTagDelim start=/{%-\?/ end=/-\?%}/ skipwhite containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment

syn region jinjaVarBlock matchgroup=jinjaVarDelim start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment

" Jinja template 'raw' tag
syn region jinjaRaw matchgroup=jinjaRawDelim start="{%\s*raw\s*%}" end="{%\s*endraw\s*%}" containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaString,jinjaComment

" Jinja comments
syn region jinjaComment matchgroup=jinjaCommentDelim start="{#" end="#}" containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaString

" Block start keywords.  A bit tricker.  We only highlight at the start of a
" tag block and only if the name is not followed by a comma or equals sign
" which usually means that we have to deal with an assignment.
syn match jinjaStatement containedin=jinjaTagBlock contained skipwhite /\({%-\?\s*\)\@<=\<[a-zA-Z_][a-zA-Z0-9_]*\>\(\s*[,=]\)\@!/

" and context modifiers
syn match jinjaStatement containedin=jinjaTagBlock contained /\<with\(out\)\?\s\+context\>/ skipwhite


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
command -nargs=+ HiLink hi def link <args>

HiLink jinjaPunctuation jinjaOperator
HiLink jinjaAttribute jinjaVariable
HiLink jinjaFunction jinjaFilter

HiLink jinjaTagDelim jinjaTagBlock
HiLink jinjaVarDelim jinjaVarBlock
HiLink jinjaCommentDelim jinjaComment
HiLink jinjaRawDelim jinja

HiLink jinjaSpecial Special
HiLink jinjaOperator Normal
HiLink jinjaRaw Normal
HiLink jinjaTagBlock PreProc
HiLink jinjaVarBlock PreProc
HiLink jinjaStatement Statement
HiLink jinjaFilter Function
HiLink jinjaBlockName Function
HiLink jinjaVariable Identifier
HiLink jinjaString Constant
HiLink jinjaNumber Constant
HiLink jinjaComment Comment

delcommand HiLink
