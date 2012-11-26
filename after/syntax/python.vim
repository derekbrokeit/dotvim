" This is a way to conceal greek characters, 
" it comes straight out of $VIMRUNTIME/syntax/tex.vim
if has("conceal") && &enc == 'utf-8'
  fun! s:pythonGreek(group,pat,cchar)
    exe "syn match ".a:group." '\\<".a:pat."\\>' conceal cchar=".a:cchar
  endfun

  call s:pythonGreek('pyGreek'  , 'alpha'   , 'α')
  call s:pythonGreek('pyGreek'  , 'beta'    , 'β')
  call s:pythonGreek('pyGreek'  , 'gamma'   , 'γ')
  call s:pythonGreek('pyGreek'  , 'delta'   , 'δ')
  call s:pythonGreek('pyGreek'  , 'epsilon' , 'ϵ')
  call s:pythonGreek('pyGreek'  , 'zeta'    , 'ζ')
  call s:pythonGreek('pyGreek'  , 'eta'     , 'η')
  call s:pythonGreek('pyGreek'  , 'theta'   , 'θ')
  call s:pythonGreek('pyGreek'  , 'kappa'   , 'κ')
  call s:pythonGreek('pyGreek'  , 'lambda'  , 'λ')
  call s:pythonGreek('pyGreek'  , 'xi'      , 'ξ')
  call s:pythonGreek('pyGreek'  , 'pi'      , 'π')
  call s:pythonGreek('pyGreek'  , 'rho'     , 'ρ')
  call s:pythonGreek('pyGreek'  , 'sigma'   , 'σ')
  call s:pythonGreek('pyGreek'  , 'tau'     , 'τ')
  call s:pythonGreek('pyGreek'  , 'upsilon' , 'υ')
  call s:pythonGreek('pyGreek'  , 'phi'     , 'φ')
  call s:pythonGreek('pyGreek'  , 'chi'     , 'χ')
  call s:pythonGreek('pyGreek'  , 'psi'     , 'ψ')
  call s:pythonGreek('pyGreek'  , 'omega'   , 'ω')

  call s:pythonGreek('pyGreek'  , 'Gamma'   , 'Γ')
  call s:pythonGreek('pyGreek'  , 'Delta'   , 'Δ')
  call s:pythonGreek('pyGreek'  , 'Theta'   , 'Θ')
  call s:pythonGreek('pyGreek'  , 'Lambda'  , 'Λ')
  call s:pythonGreek('pyGreek'  , 'Xi'      , 'Χ')
  call s:pythonGreek('pyGreek'  , 'Pi'      , 'Π')
  call s:pythonGreek('pyGreek'  , 'Sigma'   , 'Σ')
  call s:pythonGreek('pyGreek'  , 'Upsilon' , 'Υ')
  call s:pythonGreek('pyGreek'  , 'Phi'     , 'Φ')
  call s:pythonGreek('pyGreek'  , 'Psi'     , 'Ψ')
  call s:pythonGreek('pyGreek'  , 'Omega'   , 'Ω')

   call s:pythonGreek('pyGreek' , 'GAMMA'   , 'Γ')
   call s:pythonGreek('pyGreek' , 'DELTA'   , 'Δ')
   call s:pythonGreek('pyGreek' , 'THETA'   , 'Θ')
   call s:pythonGreek('pyGreek' , 'LAMBDA'  , 'Λ')
   call s:pythonGreek('pyGreek' , 'XI'      , 'Χ')
   call s:pythonGreek('pyGreek' , 'PI'      , 'Π')
   call s:pythonGreek('pyGreek' , 'SIGMA'   , 'Σ')
   call s:pythonGreek('pyGreek' , 'UPSILON' , 'Υ')
   call s:pythonGreek('pyGreek' , 'PHI'     , 'Φ')
   call s:pythonGreek('pyGreek' , 'PSI'     , 'Ψ')
   call s:pythonGreek('pyGreek' , 'OMEGA'   , 'Ω')

  delfun s:pythonGreek

  " These are for functions 
  " syn region pyGreek matchgroup=pyMathCall start="math.abs(" end=")" contained concealends contains=pymathfunc
  " syn region functs matchgroup=mathfuncs  start="math.abs(" end=")" concealends contains=pymathfunc

  setlocal conceallevel=2 
  "hi Conceal cterm=none ctermbg=235 ctermfg=darkgreen guifg=orange guibg=#646464
  hi def link pyGreek Conceal

  syntax match pyNiceOperator "\<\%(numpy\.\)\?sqrt\>" conceal cchar=√
  syntax match pyNiceKeyword "\<\%(numpy\.\)\?pi\>" conceal cchar=π
  syntax match pyNiceOperator "\<\%(np\.\)\?sqrt\>" conceal cchar=√
  syntax match pyNiceKeyword "\<\%(np\.\)\?pi\>" conceal cchar=π
endif 

