""""""""""""""""""""""""""""""
"                            "
" vim startup file ~/.vimrc "
" Derek Thomas 2012
"                            "
""""""""""""""""""""""""""""""
" --- pathogen call --- {{{1
" setup the runtime plugin bundles
" this initiates pahtogen ... MUST be before filetype detection activated
source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" --- general system setup --- {{{1
" TDOD organize by function and cleanup

" this means vim doesn't try to act like the old 'vi'
set nocompatible

" save all backups and swap files to the same local directory
set backup
set backupdir=~/.vim-tmp/backup,~/.vim-tmp/,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" This setting was necessary, or 'crontab -e' does not install crons
set backupskip=/tmp/*,/private/tmp/*"

" this allows buffers to hide in the background
set hidden

" make sure each buffer's history is remembered...and a lot of it
set history=1000
set undolevels=1000

" extended matching with '%'
runtime macros/matchit.vim

" some case insensitive searching unless case is given
set ignorecase
set smartcase

" use w!! to save a file even if sudo was not applied
cmap w!! w !sudo tee % >/dev/null

" " (this is for C and Java; users of other languages can change as they see
" fit)
set wildignore=*.o,*.class,*.asv,*~,*.swp,*.bak,*.pyc


" make foldmethod marker for better Voom
" initially folds are open, but voom will auto-enable folding
set fdm=marker
set nofoldenable

" set Session variables
" this is the save directory
" let g:session_directory="~/Dropbox/serverLogs/vim-sessions"
" let g:session_autoload = 'yes'
" "autosave
" let g:session_autosave="yes"
" set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize

" set encoding: default is utf-8
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8                     " better default than latin1
  setglobal fileencoding=utf-8           " change default file encoding when writing new files
endif

" --- commands and functions ---  {{{1
" matlab running
command! -nargs=0 Mrun echo system("rmat -b " . shellescape(expand("%:p"))) .  "rmat>> " . expand("%:t")
command! -nargs=0 Mrecall echo system("rmat -r")
" octave running
command! -nargs=0 Oct echo system("roct -r " . shellescape(expand("%:p"))) .  "octave> " . expand("%:t")

" update-system
" command! -nargs=0 SysUpdate echo system("source $HOME/.bash_profile > /dev/null ; sysupdate ")

" make sure voomclose kills the outline
com! Voomclose call Voom_DeleteOutline('')

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


function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! Ansi()
  set cole=3

  " Run AnsiEsc for colors
  AnsiEsc
  
  " Hide xterm titles
  if ! exists("g:hiddenAnsiTitle")
    syn region AnsiTitle start="]2;" end="\\" conceal
    g:hiddenAnsiTitle = "yes"
  endif
endfunction
command! -nargs=0 Ansi call Ansi()


" --- look and feel --- {{{1

" make sure we are in 256 color mode
set t_Co=256

" syntax coloring
syntax on

" disk sync after every write
"au BufWritePost * silent !sync

" set the tile of the terminal
set title
if strlen($TMUX)>0
  set titlestring=%{system('hostname\ -s')}:\ vim\ >\ %t
else
  let &titlestring=system('hostname -s').': vim '
endif

" colorscheme
set background=dark
" colorscheme desertedoceanburnt
" colorscheme synic
" colorscheme desert256
" colorscheme murphy
" colorscheme desert
colorscheme jellybeans

" turn on wildmenu
set wildmenu
set wildmode=longest:full " more bash-like (does not autocomplete)
highlight WildMenu ctermbg=darkred ctermfg=white

"turn on filetype plugins
filetype plugin on
filetype plugin indent on

" turn on help for long-lines
match ErrorMsg '\%>132v.\+'

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
set shiftround


" inactive window highlighting
hi StatusLineNC cterm=none ctermfg=black ctermbg=245 gui=none guifg=black guibg=245
"set noequalalways winminheight=0 winheight=99999

" Press space to clear search highlighting and any message already displayed.
"nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" make trailing-spaces and tabs more visible
set lcs=tab:>-,trail:·,eol:$

" reduce "press OK" messg
set shortmess=atI

" allow the backspace button to work at all times
set backspace=indent,eol,start

" turn on the line numbers
set number
highlight LineNr ctermbg=236 ctermfg=245 guibg=236 guifg=245

" highlight cursor line
highlight CursorLine ctermbg=darkred guibg=darkred
highlight CursorLineNr  ctermfg=yellow ctermbg=239
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
set statusline=\ %F%m%r%h%w\ %{fugitive#statusline()}\ [\ p:{%04l,%04v}・L:%L・%p%%\ ]

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
let g:voom_verify_oop = 1
let g:voom_user_command = "runtime! voom_addons.vim"
let g:voom_user_command = "runtime! ~/.vim/custom_headlines.vim"

" indentation instructions
"set cindent
"set cinkeys-=0#
set autoindent

" fortran options
let fortran_more_precise=1
let fortran_free_source=1
let fortran_do_enddo=1

" tab bar changes
set showtabline=2
hi TabLineFill ctermfg=LightGreen ctermbg=23 guifg=LightGreen guibg=23
hi TabLine ctermfg=blue ctermbg=23 guifg=blue guibg=23
hi TabLineSel ctermfg=lightmagenta ctermbg=23 guifg=lightmagenta guibg=23
hi Title ctermfg=lightgreen guifg=lightgreen
" this is for most-recently-used buffer (MRU)
"let MRU_Max_Entries = 150
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'


" visual mode coloring
hi VisualNOS cterm=none ctermfg=black ctermbg=250

" change highlighting of Bad-spelling
hi clear SpellBad
hi SpellBad cterm=undercurl ctermfg=196 ctermbg=236
hi SpellLocal term=underline cterm=undercurl ctermbg=22 ctermfg=white gui=undercurl guisp=Cyan
" Set region to British English
set spelllang=en_us

" turn on highlighting and set the color scheme
set hlsearch
highlight search ctermbg=240 ctermfg=red guibg=240 guifg=red

" set the easymotion highlighting
hi link EasyMotionTarget ErrorMsg
hi EasyMotionShade  ctermbg=none ctermfg=237

" use 'par' for paragraph formatting
set formatprg=par

" highlighting for vimdiff stuff
hi DiffAdd        term=bold ctermfg=white ctermbg=29 guifg=white guibg=green
hi DiffChange     term=bold ctermfg=231 ctermbg=102 guifg=white guibg=LightCyan4
hi DiffDelete     term=reverse cterm=bold ctermbg=52 gui=bold guibg=Red
hi DiffText       term=bold ctermfg=57 ctermbg=195 guifg=darkmagenta guibg=LightCyan
" --- autocommands --- {{{1
if has("autocmd")

  " add fortran commentstring
  au BufRead,BufNewFile *.f90 setlocal commentstring=!%s

  " give shell a proper commentstring
  autocmd FileType sh setlocal commentstring=#%s

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

  " open docx
  "use docx2txt.pl to allow VIm to view the text content of a .docx file directly.
  autocmd BufReadPre *.docx set ro
  autocmd BufReadPost *.docx %!docx2txt.pl 

  " open up xls files as csv 
  autocmd BufReadPre *.xls,*.xlsx set ro | setf csv
  autocmd BufReadPost *.xls,*.xlsx silent! %!xlsx2csv.sh -q -x "%" -c -
  autocmd BufReadPost *.xls,*.xlsx redraw

  " Octave syntax
  augroup filetypedetect
    au! BufRead,BufNewFile *.m,*.oct,*octaverc set filetype=matlab
    "au! BufRead,BufNewFile *.m,*.oct set filetype=octave

    au! BufRead,BufNewFile tmux.conf*,.tmux.conf* set filetype=tmux

    au! BufRead,BufNewFile *.j2 set filetype=jinja

    "LAMMPS
    au! BufRead,BufNewFile in.*           set filetype=lammps
    au! BufRead,BufNewFile *.lmp          set filetype=lammps
  augroup END

  " Use keywords from Octave syntax language file for autocomplete
  if exists("+omnifunc")
    autocmd Filetype octave
          \  if &omnifunc == "" |
          \   setlocal omnifunc=syntaxcomplete#Complete |
          \  endif
  endif

  " Source the vimrc file after saving it
  autocmd! bufwritepost vimrc source $MYVIMRC

  " strip trailing whitespace off of select filetypes when writing to file
  autocmd BufWritePre *.m,*.sh,*.py,*.js,*.txt,*.f90,*.f :call Preserve("%s/\\s\\+$//e")

  " automatically change directory to file-local-directory
  " autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
  function! OpenGitRoot()
    silent! lcd %:p:h
    let shellcmd = 'git rev-parse --show-toplevel'
    let output=system(shellcmd)
    if !v:shell_error
      silent! lcd `=output`
    endif
  endfunction
  autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | call OpenGitRoot() | endif

endif


" --- key mapping --- {{{1
" Voom: create special fold markers (a reminder of the create-tags plugin by
" the Voom author
"<Leader>fm         Create start fold marker with level number.
"                   It is apppended to the end of current line. The level is set
"                   to that of the previous start fold marker with level number
"                   (if any). The start fold marker string is obtained from option 'foldmarker'.
"<Leader>fM         Create fold marker as child: level number is incremented by 1.
"<Leader>cm         Create fold marker as comment according to buffer's filetype.
"                   E.g., if filetype is html, <!--\{\{\{1--> is appended. Dictionary
"                   s:commentstrings defines comment strings for a few filetypes.
"                   For all other filetypes, comment strings are obtained from option
"                   'commentstring'. If comment strings are not what you want, you can
"                   edit dictionary s:commentstrings.
"<Leader>cM         Create fold marker as comment and as child.

" set the leader character
let mapleader=','

" greater context when scrolling
set scrolloff=3

" move in rows instead of lines (better for wrapped text)
nnoremap j gj
nnoremap k gk

" remap the tasklist to somethign else
map <leader>l <Plug>TaskList

" Bubble multiple lines and re-select them (required "unimpaired" plugin
nmap <c-k>   [e
nmap <c-j>   ]e
xmap <c-k>   [egv
xmap <c-j>   ]egv

" this unmaps arrow keys ... let's see if I get used to text movement instead
map <up>     <nop>
map <down>   <nop>
map <left>   <nop>
map <right>  <nop>

" add surrounding white space 
" it is easy to quickly input the wrong order,
" so the reverse order of keys is also supported
map <up><space>     [<space>
map <down><space>   ]<space>
nmap <left><space>  i<space><esc>l
nmap <right><space> a<space><esc>h
map <space><up>     [<space>
map <space><down>   ]<space>
nmap <space><left>  i<space><esc>l
nmap <space><right> a<space><esc>h
nmap <space> za

" Disable commands for creating and deleting folds.
noremap zf <Nop>
noremap zF <Nop>
noremap zd <Nop>
noremap zD <Nop>
noremap zE <Nop>

" setup commandT binding
nnoremap <leader>t :CommandT<CR>
nnoremap <leader>b :CommandTBuffer<CR>

" clear search buffer
nmap <silent> <leader>/ :nohlsearch<CR>

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" faster space scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" added functionality to NERDcommenter
" add the ability to yank, comment, then past the text for comparison
nmap <silent> <leader>cp     yy <leader>cc p
vmap <silent> <leader>cp     ygv <leader>cc `>p

"nmap <silent> cp "_cw<C-R>"<Esc>

" fast moving between tabs
nnoremap <C-L> :tabn <CR>
nnoremap <C-H> :tabp <CR>

" enlarge the current buffer AND reset the view to all equal
nnoremap <C-_> <C-W>_<C-W><Bar>
nnoremap <C-W><C-W> <C-W>=

" commands for splitting windows
" window
nmap <leader>sw<left>  :topleft  vnew <CR>
nmap <leader>sw<right> :botright vnew <CR>
nmap <leader>sw<up>    :topleft  new <CR>
nmap <leader>sw<down>  :botright new <CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew <CR>
nmap <leader>s<right>  :rightbelow vnew <CR>
nmap <leader>s<up>     :leftabove  new <CR>
nmap <leader>s<down>   :rightbelow new <CR>

" kill the selected search text
nmap <silent> <leader><space> :set nolist!<CR>

" underline the current line
nmap <leader>u yypVr-

" play with the sessions
" nmap <leader>ss    :SaveSession  <CR>
" "nmap <leader>cs    :CloseSession <CR>
" nmap <leader>os    :OpenSession  <CR>
" nmap <leader>xs    :!vixs --here <CR>

"NERDTree
" nnoremap <leader>nt :NERDTreeToggle<CR>

" Voom: setup voom keys
nnoremap <leader><leader> :Voom<CR>
nnoremap <leader>n :Voomunl<CR>
nnoremap <C-c> :call Voom_DeleteOutline('q')<CR>
nnoremap <C-x> :call Voom_DeleteOutline('x')<CR>

" tabularize stuff
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>


" Visually select the text that was last edited/pasted
nmap gV `[v`]

" quick edit .vimrc
" nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>v :tabedit ~/.vim/vimrc<CR>

" Toggle spell checking on and off with `,s`
let mapleader = ","
nmap <silent> <leader>s :set spell!<CR>

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

" paste the contents of the clipboard without annoying indentation issues
let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
  " get clipboard (this automatically pastes)
  nnoremap _p :r!pbpaste<CR>

  " also, support cut/copy
  vnoremap <c-x> :!pbcopy<CR>
  vnoremap <C-c> :w !pbcopy<CR><CR>
elseif os == "Linux"
  " get ready for pasting
  " (this simply gets prepared for a paste, turn off after paste)
  nnoremap _p :set pastetoggle<CR>i
  
  " no support for cut/copy remotely yet
  vnoremap <c-x> <esc>:echoerr "Cut not supported in this os (".os.")... yet"<CR>
  vnoremap <c-c> <esc>:echoerr "Copy not supported in this os (".os.")... yet"<CR>
endif


" Identify the syntax highlighting group used at the cursor
map \c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" This is w3m settings
" highlighting:
highlight! w3mLink      ctermfg=green ctermbg=none
highlight! w3mLinkHover ctermfg=17 ctermbg=108
" highlight! w3mLinkHover ctermfg=215 ctermbg=6
highlight! w3mSubmit    ctermfg=208 cterm=bold ctermbg=none
highlight! w3mInput     term=underline cterm=underline ctermfg=yellow ctermbg=238
highlight! w3mBold      ctermfg=blue cterm=bold ctermbg=none
highlight! w3mUnderline cterm=underline ctermfg=magenta ctermbg=none
highlight! w3mHitAHint  ctermbg=darkred ctermfg=white
highlight! w3mAnchor    ctermfg=cyan cterm=none ctermbg=none
" Home Page:
let g:w3m#homepage = "http://www.google.com/ncr"
" Use Proxy:
" let &HTTP_PROXY='http://xxx.xxx/:8080'
" External browser:
let g:w3m#external_browser = 'open'
" Specify Key Of Hit-A-Hint
let g:w3m#hit_a_hint_key = 'f'
" Specify Default Search Engine
let g:w3m#search_engine = "https://www.google.co.jp/search?sourceid=chrome&ie=UTF-8&q="
" disable default keymap
" let g:w3m#disable_default_keymap = 1
" enable hover links
let g:w3m#set_hover_on = 1
" set delay time until highlighting
let g:w3m#hover_delay_time = 220

" --- Vimux bindings
" Run the current file with python
map <Leader>ry :call RunVimTmuxCommand("clear; python " . bufname("%"))<CR>
" Run the current file with the shell
map <Leader>rz :call RunVimTmuxCommand("clear; " . bufname("%"))<CR>
" Prompt for a command to run
map <Leader>rp :PromptVimTmuxCommand<CR>
" Run last command executed by RunVimTmuxCommand
map <Leader>rl :RunLastVimTmuxCommand<CR>
" Inspect runner pane
map <Leader>ri :InspectVimTmuxRunner<CR>
" Close all other tmux panes in current window
map <Leader>rx :CloseVimTmuxPanes<CR>
" Interrupt any command running in the runner pane
map <Leader>rs :InterruptVimTmuxRunner<CR>
"If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <leader>rt "vy :call RunVimTmuxCommand(@v)<CR>
" Select current paragraph (block) and send it to tmux
nmap <leader>rb vip<leader>rt<CR>
" height of tmux window (%)
let VimuxHeight = "20"
" horizontal (h) or vertical (v)
let VimuxOrientation = "v"

" opening message {{{1
" silent! echo ">^.^<" 
"

"""""""
function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
nnoremap <C-W>. :call MoveToNextTab()<CR>
nnoremap <C-W>, :call MoveToPrevTab()<CR>
