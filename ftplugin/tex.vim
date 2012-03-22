" Set colorscheme, enable conceal (except for
" " subscripts/superscripts), and match conceal
" " highlight to colorscheme
set cole=2
hi Conceal ctermbg=235 ctermfg=darkgreen guifg=green guibg=DarkGrey
" let g:tex_conceal= 'adgm'

" get the number of printed words in a tex document
nmap <buffer> <leader>w :echo system('echo tex wc: $(cat '.expand('%').' \| detex \| wc -w ) / $(wc -w '.expand('%').')')<CR>
