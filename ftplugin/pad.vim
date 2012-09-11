nmap <buffer> <silent> <enter> :call pad#EditPad()<cr>

nmap <buffer> <silent> dd :call pad#DeletePad()<cr>
nmap <buffer> <silent> _+a :call pad#ArchivePad()<cr>
nmap <buffer> <silent> _-a :call pad#UnarchivePad()<cr>
nmap <buffer> <silent> _+f :call pad#MovePad()<cr>
nmap <buffer> <silent> _-f :call pad#MovePadToSaveDir()<cr>

nmap <buffer> <silent> <esc> :bd<cr>
nmap <buffer> <silent> <S-f> :call pad#IncrementalSearch()<cr>
nmap <buffer> <silent> <S-s> :call pad#Sort()<cr>

