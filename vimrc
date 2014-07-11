"                            "
"""""""""""""""""""""""""""""
" vim startup file ~/.vimrc "
" Derek Thomas 2012
"                            "
""""""""""""""""""""""""""""""
" setup the runtime plugin bundles
" this initiates pahtogen ... MUST be before filetype detection activated
" --- pathogen call --- {{{1
source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#infect('bundle/{}')
call pathogen#helptags()

" --- general system setup --- {{{1

" this means vim doesn't try to act like the old 'vi'
set nocompatible

" keep os name as 'os'
let os = substitute(system('uname'), "\n", "", "")

" turn on filetype plugins
filetype plugin on
filetype plugin indent on

" save all backups and swap files to the same local directory
" set backup
set backupdir=~/.vim-tmp/backup,~/.vim-tmp/,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup
set nowritebackup
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

" " (this is for C and Java; users of other languages can change as they see
" fit)
set wildignore=*.o,*.class,*.asv,*~,*.swp,*.bak,*.pyc,deploy,*png,*.jpg

" set encoding: default is utf-8
if has("multi_byte")
    set encoding=utf-8                     " better default than latin1
    setglobal fileencoding=utf-8           " change default file encoding when writing new files
    if &termencoding == ""
        let &termencoding = &encoding
    endif
endif

" set keyword lookup for manual pages
set keywordprg=man

" scrolling context
set scrolloff=3

" faster space scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" folding {{{2
set fdm=marker
set foldenable

" best fold toggle
nnoremap <space> za

" Disable commands for creating and deleting folds.
noremap zf <Nop>
noremap zF <Nop>
noremap zd <Nop>
noremap zD <Nop>
noremap zE <Nop>

" --- commands and functions ---  {{{1o

" YP: copy filepath to clipboard {{{2
" the following command copies the file path to clipboard
"nnoremap <leader>yp :YP <CR>
function! YP()
    echo "Copy Path: " . expand("%:p") . system("cpath -s " . shellescape(expand("%:p")))
endfunction
command! -nargs=0 YP call YP()

" WC: character count {{{2
"nnoremap <leader>wc :WC <CR>
function! WC()
    let linecount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -l)")
    let wordcount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -w)")
    let charcount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -m)")
    echo "File Status: " . expand("%:t") . " > l:" linecount "・w:" wordcount "・c:" charcount
endfunction
command! -nargs=0 WC call WC()

" Preserve(): preserve cursor position while performing command {{{2
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

" Ansi: display ansi syntax highlighting
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

" Hexmode: toogle hexmode {{{2
" helper function to toggle hex mode
function! ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()
command! -bar Hex :Hexmode

" GitRoot() {{{2
" automatically change directory to file-local-directory
function! GitRoot()
    " returns the toplevel of the current git repository
    " if not in a git repository, it returns the cwd
    let shellcmd = 'git rev-parse --show-toplevel'
    let output = substitute(system(shellcmd), "\n", "", "")
    if v:shell_error
        let output = getcwd()
    endif
    return output
endfunction
function! GoToGitRoot()
    " takes the output of GitRoot() and moves there locally
    let gr = GitRoot()
    silent! lcd `=gr`
endfunction
command! -nargs=0 GR call GoToGitRoot()
command! Gammend Gcommit --amend

" --- look and feel --- {{{1
" colorscheme {{{"
if !exists("g:vimrc_loaded_colorscheme")
    " make sure we are in 256 color mode
    if !exists("t_Co")
        set t_Co=256
    endif

    " syntax coloring
    syntax enable

    " colorscheme
    set background=dark

    " colorscheme synic
    " colorscheme symfony
    " colorscheme asmanian_blood
    " colorscheme candy_code

    colorscheme jellybeans
    hi Normal ctermbg=NONE
    hi nonText ctermbg=NONE

    "colorscheme solarized
    " colorscheme hemisu
    " colorscheme molokai
    " colorscheme desert256

    let g:vimrc_loaded_colorscheme = 1
endif

" general settings {{{2
" turn on wildmenu
set wildmenu
set wildmode=longest:full " more bash-like (does not autocomplete)
highlight WildMenu ctermbg=darkred ctermfg=white


" this disables "visual" wrapping
set nowrap
" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

" turn off the audio-bell
set noerrorbells
set visualbell

" sets all tabs to 3-spaces
set tabstop=4
set shiftwidth=4
set expandtab
set shiftround

" make trailing-spaces and tabs more visible
set listchars=tab:>-,trail:*,eol:$

" reduce "press OK" messg
set shortmess=atI

" allow the backspace button to work at all times
set backspace=indent,eol,start

" turn on mouse-support
if has("mouse")
    set mouse=a
endif

" first, enable status line always
set laststatus=2

" indentation instructions
"set cindent
"set cinkeys-=0#
set autoindent


" --- highlighting and layout {{{2

" turn on help for long-lines
match ErrorMsg '\%>80v.\+'

" turn on the line numbers
set number
highlight LineNr ctermbg=233 ctermfg=244 guibg=#303030 guifg=#8a8a8a

" highlight cursor line
" highlight CursorLine ctermbg=52 guibg=#5F1F1F
highlight CursorLineNr  ctermfg=yellow ctermbg=234 guifg=#FFFF66 guibg=#4e4e4e
set cursorline "cursorline required to continuously update cursor position

" highlight the cursor
" hi Cursor  guifg=black guibg=lightblue gui=none
" highlight iCursor guifg=white guibg=steelblue

" tab bar changes
set showtabline=1
hi TabLineFill ctermfg=LightGreen ctermbg=23 guifg=#66CC33 guibg=#005f5f gui=none
hi TabLine ctermfg=blue ctermbg=23 guifg=lightblue guibg=#005f5f gui=none
hi TabLineSel ctermfg=lightmagenta ctermbg=23 guifg=lightmagenta guibg=#005f5f gui=bold
hi Title ctermfg=lightgreen guifg=lightgreen

" visual mode coloring
hi VisualNOS cterm=none ctermfg=black ctermbg=250 gui=none

" change highlighting of Bad-spelling
hi clear SpellBad
hi SpellBad cterm=undercurl ctermfg=196 ctermbg=236 gui=undercurl guifg=#ff0000 guibg=#303030
hi SpellLocal term=underline cterm=undercurl ctermbg=22 ctermfg=white gui=undercurl guisp=Cyan
set spelllang=en_us

" turn on highlighting and set the color scheme
set hlsearch
" highlight search ctermbg=240 ctermfg=red guibg=#585858 guifg=#FF6666 gui=underline

" set the easymotion highlighting
hi link EasyMotionTarget ErrorMsg
"hi EasyMotionShade  ctermbg=none ctermfg=237 guibg=#000000 guifg=#3a3a3a gui=none
hi EasyMotionShade  ctermfg=237 guibg=#000000 guifg=#3a3a3a gui=none


" highlighting for vimdiff stuff
hi DiffAdd        term=bold ctermfg=white ctermbg=29
hi DiffChange     term=bold ctermfg=231 ctermbg=102
hi DiffDelete     term=reverse cterm=bold ctermbg=52
hi DiffText       term=bold ctermfg=57 ctermbg=195

" change the highlighting of numbers
hi Number ctermfg=219 guifg=#ffafff

" --- autocommands --- {{{1
if has("autocmd")

    " always move buffer to local file directory upon entering
    autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

    " add fortran commentstring
    au BufRead,BufNewFile *.f90 setlocal commentstring=!%s
    au BufRead,BufNewFile *.html set ft=jinja

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

    augroup filetypedetect
        au! BufRead,BufNewFile *.m,*.oct,*octaverc set filetype=matlab

        au! BufRead,BufNewFile *.md set filetype=markdown

        au! BufRead,BufNewFile tmux.conf*,.tmux.conf* set filetype=tmux

        au! BufRead,BufNewFile *.j2 set filetype=jinja

        "LAMMPS
        au! BufRead,BufNewFile in.*           set filetype=lammps
        au! BufRead,BufNewFile *.lmp          set filetype=lammps
        au! BufRead,BufNewFile *.lammps       set filetype=lammps
    augroup END

    " Source the vimrc file after saving it
    autocmd! bufwritepost vimrc source $MYVIMRC
    autocmd! bufwritepost gvimrc source $MYGVIMRC

    " strip trailing whitespace off of select filetypes when writing to file
    autocmd BufWritePre *.m,*.sh,*.py,*.js,*.txt,*.f90,*.f :call Preserve("%s/\\s\\+$//e")

    if exists("$TMUX")
        " Get the environment variable
        let tmux_pane_name_cmd = 'tmux display -p \#D'
        let tmux_pane_name = substitute(system(g:tmux_pane_name_cmd), "\n", "", "")
        let tmux_env_var = "TMUX_PWD_" . substitute(g:tmux_pane_name, "%", "", "")
        unlet tmux_pane_name tmux_pane_name_cmd
        function! BroadcastTmuxCwd()
            let filename = substitute(expand("%:p:h"), $HOME, "~", "")
            let output = system("tmux setenv -g ".g:tmux_env_var." ".l:filename)
        endfunction
        autocmd BufEnter * call BroadcastTmuxCwd()
    endif

endif

" general mapping --- {{{1
" set the leader character
let mapleader=','

" this unmaps arrow keys ... let's see if I get used to text movement instead
map <up>     <nop>
map <down>   <nop>
map <left>   <nop>
map <right>  <nop>

" close buffer
nnoremap <C-c> :bd<CR>

" move in rows instead of lines (better for wrapped text)
nnoremap j gj
nnoremap k gk

" remap the tasklist to somethign else
nnoremap <leader>o <Plug>TaskList

" reselect text after visually moving block text
nmap [w [e
nmap ]w ]e
xmap [w [egv
xmap ]w ]egv

" setup commandT binding
nnoremap <leader>t :CommandT<CR>
nnoremap <leader>b :CommandTBuffer<CR>

" clear search buffer
nmap <silent> <leader>/ :nohlsearch<CR>

" Use Q for formatting the current paragraph (or selection)
vnoremap Q gq
nnoremap Q gqap

" fast moving between tabs
nmap [j :tabn<CR>
nmap ]j :tabp<CR>
nmap <C-t> :tabnew <CR>:GR<CR>:echo expand("%:p:h")<CR>

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
nnoremap <leader>u yypVr-

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

" quick edit .vimrc
nmap <leader>v :tabedit ~/.vim/vimrc<CR>

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

" spell check
nmap <silent> <leader>sp :set spell!<CR>

" quick paste {{{2
" paste the contents of the clipboard without annoying indentation issues
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

" Add white space {{{2
" it is easy to quickly input the wrong order,
" so the reverse order of keys is also supported
map <up><space>     [<space>
map <down><space>   ]<space>
nnoremap <left><space>  i<space><esc>l
nnoremap <right><space> a<space><esc>h

" display syntax groups {{{2
" Identify the syntax highlighting group used at the cursor
if has("gui_macvim")
    nmap ¥c <esc>:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
else
    nmap \c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
endif

" PATH  {{{1
" have to put at end because of PATH
let homebrew_prefix = substitute(system("brew --prefix"),"\n","","")
let Tlist_Ctags_Cmd=homebrew_prefix . "/bin/ctags"
let g:tagbar_ctags_bin = homebrew_prefix . "/bin/ctags"
" use 'par' for paragraph formatting
set formatprg="par"


" Plugin settings {{{1o
"NERDTree {{{2
nnoremap <leader>nt :NERDTreeMirrorToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '\.o$']
let NERDTreeMinimalUI=1
if os == "Darwin"
    let NERDTreeDirArrows=1
else
    let NERDTreeDirArrows=0
endif
" tab setup customization
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_open_on_gui_startup = 0
" vim-sessions {{{2
" set Session variables
let g:session_command_aliases = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5
let g:session_autoload = 'yes'
if !exists("g:session_directory_chosen")
    let g:session_directory_chosen = 1
    " this is the save directory
    if os == "Darwin"
        let g:session_directory="~/Dropbox/serverLogs/vim-sessions_" . hostname()
    else
        let g:session_directory="~/logs/vim-sessions_".hostname()
    endif
    " attempt to find local directory vim-sessions, which would likelly
    " be at the git top level
    " inspired by: https://github.com/xolox/vim-session/issues/49
    let s:local_session_directory = GitRoot() . '/.vimsessions'
    if isdirectory(s:local_session_directory)
        let g:session_directory = s:local_session_directory
    endif
    unlet s:local_session_directory
endif
" commands for sessions
command! SS  wall | SaveSession
command! SC wall | SaveSession | CloseSession
command! SQ wall | SaveSession | CloseSession | q
command! SO  OpenSession

" Voom options {{{2
let g:voom_user_command = "runtime!  voom_addons/custom_headlines.vim"
" make sure voomclose kills the outline
command! VC call Voom_DeleteOutline('')
" Voom: setup voom keys
nnoremap <leader><leader> :Voom<CR>
nnoremap <leader><leader>n :Voomunl<CR>

" tabularize {{{2
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a3 vip:Tabularize /\#<CR>
vmap <Leader>a3 :Tabularize /\#<CR>

" vimux {{{2
" open tmux pane and go to the current director
nnoremap <leader>rg :call VimuxRunCommand("cd " . expand("%:p:h"))<CR>
" Run the current file with python
nnoremap <Leader>ry :call VimuxRunCommand("clear; python " . bufname("%"))<CR>
nnoremap <leader>re :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>
" Run the current file with the shell
nnoremap <Leader>rz :call VimuxRunCommand("clear; " . bufname("%"))<CR>
" Prompt for a command to run
nnoremap <Leader>rp :VimuxPromptCommand<CR>
" Run last command executed by RunVimTmuxCommand
nnoremap <Leader>rl :VimuxRunLastCommand<CR>
" Inspect runner pane
nnoremap <Leader>ri :VimuxInspectRunner<CR>
" Close all other tmux panes in current window
nnoremap <Leader>rx :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
nnoremap <Leader>rs :VimuxInterruptRunner<CR>
"If text is selected, save it in the v buffer and send that buffer it to tmux
vnoremap <leader>rt "vy :call VimuxRunCommand(@v . "\n", 0)<CR>
" Select current paragraph (block) and send it to tmux
nnoremap <leader>rb vip<leader>rt<CR>
" vimux options
let VimuxHeight = "20"
let VimuxOrientation = "v"
let VimuxUseNearestPane = 1


" w3m {{{2
" highlighting:
highlight! w3mLink      ctermfg=green ctermbg=none guifg=#66CC33
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
" ctags are great, open up taglist window:
"nnoremap _t :TlistOpen<CR>
nnoremap _t :TagbarToggle<CR>

" vim-pad {{{2
if os == "Darwin"
    "let g:pad_dir = "~/Dropbox/notes/"
    let g:pad_dir = "~/Library/Mobile\ Documents/N39PJFAFEV\~com\~metaclassy\~byword/Documents"
elseif os == "Linux"
    let g:pad_dir = "~/notes"
endif
let g:pad_window_height = 15
let g:pad_use_default_mappings = 0
let g:pad_highlighting_variant = 0
let g:pad_default_file_extension = ".md"
nmap <silent> _o <Plug>ListPads
nmap <silent> _n <Plug>OpenPad
nmap <silent> _s <Plug>SearchPads

" this is for most-recently-used buffer (MRU)
"let MRU_Max_Entries = 150
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'

" Syntastic {{{2
" check errors and go to the first
nmap <leader>e :Errors<CR>[L
let g:syntastic_python_flake8_args='--ignore=E501'

" Gundo {{{2
map <leader>g :GundoToggle<CR>

" " Powerline {{{2
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set rtp+=~/powerline/powerline/bindings/vim

