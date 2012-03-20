" From: http://vim.wikia.com/wiki/Keep_your_vimrc_file_clean
" File ~/.vim/ftplugin/python.vim
" ($HOME/vimfiles/ftplugin/python.vim on Windows)
" Python specific settings.
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal formatoptions=croql

command! -nargs=0 Runpy !python %
nmap <buffer> <leader>r :w<CR>:!python %<CR>
nmap <buffer> <leader>R :w<CR>:!ipython %<CR>


" setlocal tags+=~/.vim/ctags/py_matplotlib
"

" turn off ipython mappings
let g:ipy_perform_mappings=0
" --- IPython bindings remapped
map <silent><buffer> <leader>R :w<CR>:python run_this_file()<CR>
map <silent><buffer> <leader>r :w<CR>:python dedent_run_these_line()<CR>
nmap <silent><buffer> <leader>d :py get_doc_buffer()<CR>
vmap <silent><buffer> <C-S> :w<CR>:python run_these_lines()<CR>
" vmap <silent><buffer> <leader>r python dedent_run_these_lines()<CR>
"" Example of how to quickly clear the current plot with a keystroke
"map <silent> <F12> :python run_command("plt.clf()")<cr>
"" Example of how to quickly close all figures with a keystroke
"map <silent> <F11> :python run_command("plt.close('all')")<cr>
"pi custom
" nmap <silent> <C-Return> :python run_this_file()<CR>
imap <silent> <C-s> <esc>:w<CR>:python run_this_line()<CR>
" nmap <silent> <M-s> :python dedent_run_this_line()<CR>
" vmap <silent> <C-S> :python run_these_lines()<CR>
" vmap <silent> <M-s> :python dedent_run_these_lines()<CR>

" This is a way to conceal greek characters, 
" it comes straight out of $VIMRUNTIME/syntax/tex.vim
if has("conceal") && &enc == 'utf-8'
  fun! s:pythonGreek(group,pat,cchar)
    exe 'syn match '.a:group." '".a:pat."' conceal cchar=".a:cchar
  endfun

  call s:pythonGreek('pyGreek'                      , 'alpha'                    , 'α')
  call s:pythonGreek('pyGreek'                      , 'beta'                     , 'β')
  call s:pythonGreek('pyGreek'                      , 'gamma'                    , 'γ')
  call s:pythonGreek('pyGreek'                      , 'delta'                    , 'δ')
  call s:pythonGreek('pyGreek'                      , 'epsilon'                  , 'ϵ')
  call s:pythonGreek('pyGreek'                      , 'zeta'                     , 'ζ')
  call s:pythonGreek('pyGreek'                      , 'eta'                      , 'η')
  call s:pythonGreek('pyGreek'                      , 'theta'                    , 'θ')
  call s:pythonGreek('pyGreek'                      , 'kappa'                    , 'κ')
  " all lambda not used for making lambda-functions
  call s:pythonGreek('pyGreek'                      , 'lambda\(\s*\(\w\)*:\)\@!' , 'λ')
  call s:pythonGreek('pyGreek'                      , 'mu'                       , 'μ')
  call s:pythonGreek('pyGreek'                      , 'nu'                       , 'ν')
  call s:pythonGreek('pyGreek'                      , 'xi'                       , 'ξ')
  call s:pythonGreek('pyGreek'                      , 'pi'                       , 'π')
  call s:pythonGreek('pyGreek'                      , 'rho'                      , 'ρ')
  call s:pythonGreek('pyGreek'                      , 'sigma'                    , 'σ')
  call s:pythonGreek('pyGreek'                      , 'tau'                      , 'τ')
  call s:pythonGreek('pyGreek'                      , 'upsilon'                  , 'υ')
  call s:pythonGreek('pyGreek'                      , 'phi'                      , 'φ')
  call s:pythonGreek('pyGreek'                      , 'chi'                      , 'χ')
  call s:pythonGreek('pyGreek'                      , 'psi'                      , 'ψ')
  call s:pythonGreek('pyGreek'                      , 'omega'                    , 'ω')

  call s:pythonGreek('pyGreek'                      , 'Gamma'                    , 'Γ')
  call s:pythonGreek('pyGreek'                      , 'Delta'                    , 'Δ')
  call s:pythonGreek('pyGreek'                      , 'Theta'                    , 'Θ')
  call s:pythonGreek('pyGreek'                      , 'Lambda'                   , 'Λ')
  call s:pythonGreek('pyGreek'                      , 'Xi'                       , 'Χ')
  call s:pythonGreek('pyGreek'                      , 'Pi'                       , 'Π')
  call s:pythonGreek('pyGreek'                      , 'Sigma'                    , 'Σ')
  call s:pythonGreek('pyGreek'                      , 'Upsilon'                  , 'Υ')
  call s:pythonGreek('pyGreek'                      , 'Phi'                      , 'Φ')
  call s:pythonGreek('pyGreek'                      , 'Psi'                      , 'Ψ')
  call s:pythonGreek('pyGreek'                      , 'Omega'                    , 'Ω')

  " The following are commented out because they are likely to be used in
  " constants which would be best left alone
  " call s:pythonGreek('pyGreek'                      , 'GAMMA'                    , 'Γ')
  " call s:pythonGreek('pyGreek'                      , 'DELTA'                    , 'Δ')
  " call s:pythonGreek('pyGreek'                      , 'THETA'                    , 'Θ')
  " call s:pythonGreek('pyGreek'                      , 'LAMBDA'                   , 'Λ')
  " call s:pythonGreek('pyGreek'                      , 'XI'                       , 'Χ')
  " call s:pythonGreek('pyGreek'                      , 'PI'                       , 'Π')
  " call s:pythonGreek('pyGreek'                      , 'SIGMA'                    , 'Σ')
  " call s:pythonGreek('pyGreek'                      , 'UPSILON'                  , 'Υ')
  " call s:pythonGreek('pyGreek'                      , 'PHI'                      , 'Φ')
  " call s:pythonGreek('pyGreek'                      , 'PSI'                      , 'Ψ')
  " call s:pythonGreek('pyGreek'                      , 'OMEGA'                    , 'Ω')

  delfun s:pythonGreek

  setlocal conceallevel=2 
  hi Conceal cterm=none ctermbg=235 ctermfg=darkgreen guifg=green guibg=DarkGrey
endif 

