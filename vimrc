" this initiates pahtogen ... MUST be before filetype detection activated
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
 
" TDOD organize by function and cleanup

" this means vim doesn't try to act like the old 'vi'
set nocompatible

" save all backups and swap files to the same local directory
set backupdir=~/.vim-tmp/backup,~/.vim-tmp/,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" turn on backups 
set backup

" this allows buffers to hide in the background
set hidden

" make sure each buffer's history is remembered...and a lot of it
set history=1000
set undolevels=1000

" extended matching with '%'
runtime macros/matchit.vim

" set the leader character
let mapleader=','

" some case insensitive searching unless case is given
set ignorecase 
set smartcase

" greater context when scrolling
set scrolloff=3

" move in rows instead of lines (better for wrapped text)
nnoremap j gj
nnoremap k gk

" remap the tasklist to somethign else
map <leader>l <Plug>TaskList

" this unmaps arrow keys ... let's see if I get used to text movement instead
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" setup commandT binding
nnoremap <leader>t :CommandT<CR>
nnoremap <leader>bt :CommandTBuffer<CR>

" clear search buffer
nmap <silent> <leader>/ :nohlsearch<CR>

" use w!! to save a file even if sudo was not applied
cmap w!! w !sudo tee % >/dev/null

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" faster space scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" make sure we are in 256 color mode
set t_Co=256

" This setting was necessary, or 'crontab -e' does not install crons
set backupskip=/tmp/*,/private/tmp/*" 

" syntax coloring
syntax on

" disk sync after every write
"au BufWritePost * silent !sync

" " (this is for C and Java; users of other languages can change as they see
" fit)
set wildignore=*.o,*.class,*.asv,*~,*.swp,*.bak,*.pyc

" automatically change directory to file-local-directory
"autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" set the tile of the terminal
set titlestring=%{system('hostname\ -s')}\ >\ vim:\ %{expand(\"%\")}
set title

" colorscheme
colorscheme synic 
"colorscheme jellybeans 

" turn on wildmenu
set wildmenu
set wildmode=longest:full " more bash-like (does not autocomplete) 
highlight WildMenu ctermbg=darkred ctermfg=white

"turn on filetype plugins
"filetype plugin on
filetype plugin indent on

" turn on help for long-lines
:match ErrorMsg '\%>132v.\+'

" this enables "visual" wrapping
set wrap

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

" turn off the audio-bell
"set visualbell
set errorbells
set novisualbell

" sets all tabs to 3-spaces
set tabstop=2
set shiftwidth=2
set expandtab

" turn on highlighting and set the color scheme
set hlsearch
highlight search ctermbg=240 ctermfg=red guibg=240 guifg=red 

" inactive window highlighting
hi StatusLineNC cterm=none ctermfg=black ctermbg=245 gui=none guifg=black guibg=245
"set noequalalways winminheight=0 winheight=99999

" Press space to clear search highlighting and any message already displayed.
"nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" make trailing-spaces and tabs more visible
set lcs=tab:>-,trail:·,eol:$
nmap <silent> <leader><space> :set nolist!<CR>      

" reduce "press OK" messg
set shortmess=atI

" allow the backspace button to work at all times
set backspace=indent,eol,start

" turn on the line numbers
set number
highlight LineNr ctermbg=236 ctermfg=245 guibg=236 guifg=245

" highlight cursor line
highlight CursorLine ctermbg=darkred guibg=darkred
set cursorline "cursorline required to continuously update cursor position
"hi Cursor cterm=none ctermfg=black ctermbg=darkgreen
"match Cursor /\%#/ "This line does all the work
"237

" turn on mouse-support
if has("mouse")
    set mouse=a
endif
"map <ScrollWheelUp> <C-Y>
"map <S-ScrollWheelUp> <C-U>
"map <ScrollWheelDown> <C-E>
"map <S-ScrollWheelDown> <C-D>

" first, enable status line always
set laststatus=2
set statusline=\ %F%m%r%h%w\ [\ p:{%04l,%04v}・L:%L・%p%%\ ] 

" setup status bar that is color coded based on insert/replace methodology
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermfg=black ctermbg=yellow guifg=black guibg=yellow
  elseif a:mode == 'r'
    hi statusline ctermfg=black ctermbg=darkred guifg=black guibg=darkred
  else
    hi statusline ctermfg=black ctermbg=darkblue guifg=black guibg=darkblue
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermfg=black ctermbg=darkgreen guifg=black guibg=darkgreen

" default the statusline to green when entering Vim
hi statusline ctermfg=0 ctermbg=2 guifg=0 guibg=2

" Voom options
"if exists(":Voom")
  set fdm=marker
  let g:voom_verify_oop = 1
  let g:voom_user_command = "runtime! voom_addons/*.vim"
  nnoremap <LocalLeader><LocalLeader> :Voom<CR>
  nnoremap <LocalLeader>n :Voomunl<CR>
  nnoremap <C-c> :call Voom_DeleteOutline('q')<CR>
  nnoremap <C-x> :call Voom_DeleteOutline('x')<CR>
  com! Voomclose call Voom_DeleteOutline('')
"endif

" Disable commands for creating and deleting folds.
noremap zf <Nop>
noremap zF <Nop>
noremap zd <Nop>
noremap zD <Nop>
noremap zE <Nop>

" indentation instructions
"set cindent
"set cinkeys-=0#
set autoindent

" fortran options
let fortran_more_precise=1
let fortran_free_source=1
let fortran_do_enddo=1
au BufRead,BufNewFile *.f90 setlocal commentstring=!%s

" lammps commentstring
au BufRead,BufNewFile in.* setlocal commentstring=#%s

" give shell a proper commentstring
autocmd FileType sh setlocal commentstring=#%s

" added functionality to NERDcommenter
"nnoremap <leader>cp :!tmux send-keys "\cy" "p" <CR>
nmap <silent> <leader>cp :call NERDComment(0, "yank")<CR>p
vmap <silent> <plug><leader>cp <ESC>:call NERDComment(1, "yank")<CR>p

nmap <silent> cp "_cw<C-R>"<Esc>

" tab bar changes
set showtabline=2
:hi TabLineFill ctermfg=LightGreen ctermbg=23 guifg=LightGreen guibg=23
:hi TabLine ctermfg=blue ctermbg=23 guifg=blue guibg=23
:hi TabLineSel ctermfg=lightmagenta ctermbg=23 guifg=lightmagenta guibg=23
:hi Title ctermfg=lightgreen guifg=lightgreen
nnoremap <C-L> :tabn <CR>
nnoremap <C-H> :tabp <CR>
nnoremap <C-J> <C-W>j<C-W>_ <CR>
nnoremap <C-K> <C-W>k<C-W>_ <CR>
nnoremap <C-W><C-W> <C-W>=

" commands for splitting windows
" window
nmap <leader>sw<left>  :topleft  vnew ./<CR>
nmap <leader>sw<right> :botright vnew ./<CR>
nmap <leader>sw<up>    :topleft  new ./<CR>
nmap <leader>sw<down>  :botright new ./<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew ./<CR>
nmap <leader>s<right>  :rightbelow vnew ./<CR>
nmap <leader>s<up>     :leftabove  new ./<CR>
nmap <leader>s<down>   :rightbelow new ./<CR>

" this is for most-recently-used buffer (MRU)
"let MRU_Max_Entries = 150
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'

" the following command copies the file path to clipboard
"nnoremap <leader>yp :YP <CR>
function! YP()
   echo "Copy Path: " . expand("%:p") . system("cpath -s " . shellescape(expand("%:p")))
endfunction
command! -nargs=0 YP call YP()

" character count
"nnoremap <leader>wc :WC <CR>
function! WC()
   let linecount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -l)")
   let wordcount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -w)")
   let charcount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -m)")
   echo "File Status: " . expand("%:t") . " > l:" linecount "・w:" wordcount "・c:" charcount 
endfunction
command! -nargs=0 WC call WC()

" visual mode coloring
hi VisualNOS cterm=none ctermfg=black ctermbg=250

" coppying selection
"nnoremap <leader>yl
"in visual-mode > select desired lines > type "!pbcopy" > ??? > profit

" set Session variables
" this is the save directory
"if exists(":SaveSession")
  let g:session_directory="~/Dropbox/serverLogs/vim-sessions"
  let g:session_autoload = 'yes'
  "autosave
  let g:session_autosave="yes"
  set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
  nmap <leader>ss    :SaveSession  <CR>
  "nmap <leader>cs    :CloseSession <CR>
  nmap <leader>os    :OpenSession  <CR>
  nmap <leader>xs    :!vixs --here <CR>
"endif

"NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR> 

" this was thought to correct an error, but it had no effect
"let g:netrw_silent=1
"let g:netrw_use_noswf=0


" open pdf files?
autocmd BufReadPre *.pdf set ro nowrap
"autocmd BufReadPost *.pdf silent %!pdftotext "%" -nopgbrk -layout -q -eol unix -
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -cs -w 72
autocmd BufWritePost *.pdf silent !rm -rf ~/PDF/%
autocmd BufWritePost *.pdf silent !lp -s -d pdffg "%"
autocmd BufWritePost *.pdf silent !until [ -e ~/PDF/% ]; do sleep 1; done
autocmd BufWritePost *.pdf silent !mv ~/PDF/% %:p:h

" open doc files?
" View word documents in Vim (good for diff'ing).
autocmd BufReadPre *.doc  set ro
autocmd BufReadPre *.doc  set hlsearch
autocmd BufReadPost *.doc silent %!antiword '%:p'

" moving around
"Jump between windows
"map <Space> <c-W>w

"Open window wide
"nmap <Space><Space> :call OpenSplittedWindowWide()<CR>
"function! OpenSplittedWindowWide()
"   normal |
"   normal 20+
"endfunction


" matlab running
command! -nargs=0 Mrun echo system("rmat -b " . shellescape(expand("%:p"))) .  "rmat>> " . expand("%:t")
command! -nargs=0 Mrecall echo system("rmat -r")
" octave running
command! -nargs=0 Oct echo system("roct -r " . shellescape(expand("%:p"))) .  "octave> " . expand("%:t")

" update-system
command! -nargs=0 SysUpdate echo system("source $HOME/.bash_profile > /dev/null ; sysupdate ")
command! -nargs=0 ReSource source $HOME/.vimrc

" Octave syntax 
augroup filetypedetect 
  au! BufRead,BufNewFile *.m,*.oct,*octaverc set filetype=matlab 
  "au! BufRead,BufNewFile *.m,*.oct set filetype=octave
  
  au! BufRead,BufNewFile tmux.conf*,.tmux.conf* set filetype=tmux
augroup END 
" set the compiler based on filetype
"au BufRead * try | execute "compiler ".&filetype | catch /./ | endtry
au BufRead *.m try | execute "compiler matlab" | catch /./ | endtry

"" Use keywords from Octave syntax language file for autocomplete 
if has("autocmd") && exists("+omnifunc") 
   autocmd Filetype octave 
      \  if &omnifunc == "" | 
      \   setlocal omnifunc=syntaxcomplete#Complete | 
      \  endif 
endif 


" underline the current line
nmap <leader>u yypVr-

"If this is Terminal.app, do cursor hack for visible cursor
"This hack does not behave well with other terminals (particularly xterm)
"function! MacOSX()
  "hi CursorLine term=none cterm=none "Invisible CursorLine
  "set cursorline "cursorline required to continuously update cursor position
  "hi Cursor cterm=none "I like a reversed cursor, edit this to your liking
  "match Cursor /\%#/ "This line does all the work
"endfunction
"call MacOSX()
"if $TERM_PROGRAM == "Apple_Terminal" " Terminal.app, xterm and urxvt pass this test
 "if $WINDOWID == ""                  " xterm and urxvt don't pass this test
  ""It is unlikely that anything except Terminal.app will get here
  "call MacOSX()
 "endif
"endif

"if $SSH_TTY != ""            " If the user is connected through ssh
 "if $TERM == "xterm-color*" || $ORIGTERM = "xterm-color*"
  ""Something other than Terminal.app might well get here
  "call MacOSX()
 "endif
"endif


" tabularize stuff
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

