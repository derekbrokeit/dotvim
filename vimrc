"""""""""""""""""""""""""""""
" vim startup file ~/.vimrc "
" Derek Thomas 2012
"                            "
""""""""""""""""""""""""""""""
" --- ensure that the shell works --- {{{1
set shell=/bin/zsh

" --- setup Vundle --- {{{1
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'google/vim-maktaba'
Plugin 'bazelbuild/vim-bazel'
Plugin 'vim-python/python-syntax'
Plugin 'tpope/vim-fugitive'
Plugin 'previm/previm'
Plugin 'tyru/open-browser.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'edkolev/tmuxline.vim'
Plugin 'Vigemus/iron.nvim', {'do': ':UpdateRemotePlugins'}
" other tpope plugins
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
" Git plugin not hosted on GitHub
Plugin 'wincent/command-t'
" better abbreviations and substitutions
Plugin 'epmatsw/ag.vim'
"Plugin 'vim-scripts/AnsiEsc.vim'
Plugin 'powerman/vim-plugin-AnsiEsc'
Plugin 'vim-scripts/DrawIt'
Plugin 'easymotion/vim-easymotion'
" Plugin 'sjl/gundo.vim'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'othree/html5-syntax.vim'
Plugin 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/RST-Tables'
Plugin 'xolox/vim-session'
Plugin 'garbas/vim-snipmate'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/SyntaxAttr.vim'
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'tomtom/tlib_vim'
"Plugin 'christoomey/vim-tmux-navigator'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'xolox/vim-misc'
Plugin 'honza/vim-snippets'
Plugin 'fmoralesc/vim-pad'
"Plugin 'benmills/vimux'
"Plugin 'yuratomo/w3m.vim'
"Plugin 'tmux-plugins/vim-tmux'
"syntax highlighting for xonsh
Plugin 'linkinpark342/xonsh-vim'
Plugin 'Asheq/close-buffers.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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
set wildignore=*.o,*.class,*.asv,*~,*.swp,*.bak,*.pyc,deploy,*png,*.jpg,*/build/*

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

" folding {{{1
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

" YP: copy filepath to clipboard {{{1
" the following command copies the file path to clipboard
"nnoremap <leader>yp :YP <CR>
function! YP()
    echo "Copy Path: " . expand("%:p") . system("cpath -s " . shellescape(expand("%:p")))
endfunction
command! -nargs=0 YP call YP()

" WC: character count {{{1
"nnoremap <leader>wc :WC <CR>
function! WC()
    let linecount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -l)")
    let wordcount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -w)")
    let charcount=system("echo -n $(cat " . shellescape(expand("%:p")) . " | wc -m)")
    echo "File Status: " . expand("%:t") . " > l:" linecount "・w:" wordcount "・c:" charcount
endfunction
command! -nargs=0 WC call WC()

" Preserve(): preserve cursor position while performing command {{{1
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

" Hexmode: toogle hexmode {{{1
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

" GitRoot() {{{1
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

" general settings {{{1
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

" sets all tabs to 4-spaces
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


" --- highlighting and layout {{{1

" turn on help for long-lines
" match ErrorMsg '\%>88v.\+'

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
" hi TabLineFill ctermfg=LightGreen ctermbg=23 guifg=#66CC33 guibg=#005f5f gui=none
" hi TabLine ctermfg=blue ctermbg=23 guifg=lightblue guibg=#005f5f gui=none
" hi TabLineSel ctermfg=lightmagenta ctermbg=23 guifg=lightmagenta guibg=#005f5f gui=bold
" hi Title ctermfg=lightgreen guifg=lightgreen

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

    " redraw screen
    au BufRead,BufNewFile,BufWritePost * redraw

    " add fortran commentstring
    au BufRead,BufNewFile *.f90 setlocal commentstring=!%s

    " html is now shown as jinja
    au BufRead,BufNewFile *.html set ft=jinja

    " show gcode using ngc syntax highlighting
    au BufRead,BufNewFile *.gcode,*.g,*.ngc set ft=g

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
let g:CommandTMaxFiles = 2000000
let g:CommandTSuppressMaxFilesWarning = 1

" clear search buffer
nmap <silent> <leader>/ :nohlsearch<CR>

" Use Q for formatting the current paragraph (or selection)
vnoremap Q gq
nnoremap Q gqap

" fast moving between tabs
nmap [j :tabn<CR>
nmap ]j :tabp<CR>
nmap <c-n> :tabn<CR>
nmap <c-p> :tabp<CR>
nmap <C-t> :tabnew <CR>:GR<CR>:echo expand("%:p:h")<CR>

" enlarge the current buffer AND reset the view to all equal
" nnoremap <C-_> <C-W>_<C-W><Bar>
" nnoremap <C-W><C-W> <C-W>=
nnoremap <C-_> <C-W>_<C-W><Bar>
nnoremap <C-W><c-W> <C-W>=
nnoremap <M-l> <C-W>l
nnoremap <M-k> <C-W>k
nnoremap <M-j> <C-W>j
nnoremap <M-h> <C-W>h

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

" quick paste {{{1
" paste the contents of the clipboard without annoying indentation issues
if os == "Darwin"
    " get clipboard (this automatically pastes)
    nnoremap _p :r!pbpaste<CR>

    " also, support cut/copy
    vnoremap <c-x> :!pbcopy<CR>
    vnoremap <C-c> :w !pbcopy<CR><CR>
elseif os == "Linux"
    set clipboard+=unnamedplus

    " " no support for cut/copy remotely yet
    " vnoremap <c-x> <esc>:echoerr "Cut not supported in this os (".os.")... yet"<CR>
    " vnoremap <c-c> <esc>:echoerr "Copy not supported in this os (".os.")... yet"<CR>
endif

" Add white space {{{1
" it is easy to quickly input the wrong order,
" so the reverse order of keys is also supported
map <up><space>     [<space>
map <down><space>   ]<space>
nnoremap <left><space>  i<space><esc>l
nnoremap <right><space> a<space><esc>h

" display syntax groups {{{1
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
if os == "Darwin"
    let homebrew_prefix = substitute(system("brew --prefix"),"\n","","")
    let Tlist_Ctags_Cmd=homebrew_prefix . "/bin/ctags"
    let g:tagbar_ctags_bin = homebrew_prefix . "/bin/ctags"
endif
" use 'par' for paragraph formatting
set formatprg="par"


" Plugin settings {{{1o
"NERDTree {{{1
nnoremap <leader>nt :NERDTreeMirrorToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '\.o$']
let NERDTreeMinimalUI=1
if os == "Darwin"
    let NERDTreeDirArrows=1
else
    let NERDTreeDirArrows=0
endif
" tab setup customization
" let g:nerdtree_tabs_open_on_console_startup = 0
" let g:nerdtree_tabs_open_on_gui_startup = 0
" vim-sessions {{{1
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

" " Voom options {{{1
" let g:voom_user_command = "runtime!  voom_addons/custom_headlines.vim"
" " make sure voomclose kills the outline
" command! VC call Voom_DeleteOutline('')
" " Voom: setup voom keys
" nnoremap <leader><leader> :Voom<CR>
" nnoremap <leader><leader>n :Voomunl<CR>

" tabularize {{{1
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a3 vip:Tabularize /\#<CR>
vmap <Leader>a3 :Tabularize /\#<CR>

"" vimux {{{1
"" open tmux pane and go to the current director
"nnoremap <leader>rg :call VimuxRunCommand("cd " . expand("%:p:h"))<CR>
"" Run the current file with python
"nnoremap <Leader>ry :call VimuxRunCommand("clear; python " . bufname("%"))<CR>
"nnoremap <leader>re :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>
"" Run the current file with the shell
"nnoremap <Leader>rz :call VimuxRunCommand("clear; " . bufname("%"))<CR>
"" Prompt for a command to run
"nnoremap <Leader>rp :VimuxPromptCommand<CR>
"" Run last command executed by RunVimTmuxCommand
"nnoremap <Leader>rl :VimuxRunLastCommand<CR>
"" Inspect runner pane
"nnoremap <Leader>ri :VimuxInspectRunner<CR>
"" Close all other tmux panes in current window
"nnoremap <Leader>rx :VimuxCloseRunner<CR>
"" Interrupt any command running in the runner pane
"nnoremap <Leader>rs :VimuxInterruptRunner<CR>
""If text is selected, save it in the v buffer and send that buffer it to tmux
"vnoremap <leader>rt "vy :call VimuxRunCommand(@v . "\n", 0)<CR>
"" Select current paragraph (block) and send it to tmux
"nnoremap <leader>rb vip<leader>rt<CR>
"" vimux options
"let VimuxHeight = "20"
"let VimuxOrientation = "v"
"let VimuxUseNearestPane = 1


" " w3m {{{1
" " highlighting:
" highlight! w3mLink      ctermfg=green ctermbg=none guifg=#66CC33
" highlight! w3mLinkHover ctermfg=17 ctermbg=108
" " highlight! w3mLinkHover ctermfg=215 ctermbg=6
" highlight! w3mSubmit    ctermfg=208 cterm=bold ctermbg=none
" highlight! w3mInput     term=underline cterm=underline ctermfg=yellow ctermbg=238
" highlight! w3mBold      ctermfg=blue cterm=bold ctermbg=none
" highlight! w3mUnderline cterm=underline ctermfg=magenta ctermbg=none
" highlight! w3mHitAHint  ctermbg=darkred ctermfg=white
" highlight! w3mAnchor    ctermfg=cyan cterm=none ctermbg=none
" " Home Page:
" let g:w3m#homepage = "http://www.google.com/ncr"
" " Use Proxy:
" " let &HTTP_PROXY='http://xxx.xxx/:8080'
" " External browser:
" let g:w3m#external_browser = 'open'
" " Specify Key Of Hit-A-Hint
" let g:w3m#hit_a_hint_key = 'f'
" " Specify Default Search Engine
" let g:w3m#search_engine = "https://www.google.co.jp/search?sourceid=chrome&ie=UTF-8&q="
" " disable default keymap
" " let g:w3m#disable_default_keymap = 1
" " enable hover links
" let g:w3m#set_hover_on = 1
" " set delay time until highlighting
" let g:w3m#hover_delay_time = 220



" ctags are great, open up taglist window:
"nnoremap _t :TlistOpen<CR>
nnoremap _t :TagbarToggle<CR>

" vim-pad {{{1
if os == "Darwin"
    "let g:pad_dir = "~/Dropbox/notes/"
    let g:pad#dir = "~/Library/Mobile\ Documents/N39PJFAFEV\~com\~metaclassy\~byword/Documents"
elseif os == "Linux"
    let g:pad#dir = "~/notes"
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

" Syntastic {{{1
" check errors and go to the first
nmap <leader>e :Errors<CR>[L
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--max-complexity 10 --max-line-length 88 --ignore=E203,E266,E501,W503,E252'
let g:syntastic_python_checkers=["flake8"]

" " Gundo {{{1
" map <leader>g :GundoToggle<CR>

" " " Powerline {{{1
let g:airline_theme='jellybeans'
"let g:airline_powerline_fonts = 1
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup
" set rtp+=~/powerline/powerline/bindings/vim
""set rtp+=$HOME/.config/lib/python2.7/site-packages/powerline/bindings/vim/
"" Always show statusline
"set laststatus=2
"set t_Co=256

" " vim-tmux navigator {{{1
" let g:tmux_navigator_no_mappings = 1
" let g:tmux_navigator_disable_when_zoomed = 1

" nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <C-j> :TmuxNavigateDown<cr>nnoremap
" nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

let g:python_highlight_all = 1

" REPL {{{1
if has('nvim')
    nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

    nnoremap <leader>x  :rightbelow new<CR>:terminal /bin/zsh<CR>
    tnoremap <C-T> <C-\><C-n>yaW:rightbelow<space>vnew<space><C-R>0<CR>

    nnoremap <leader>ir :IronRepl<cr>
    tnoremap <Esc> <C-\><C-n>
    " tnoremap <C-l> <Esc><C-l>
    " tnoremap <C-k> <Esc><C-k>
    " tnoremap <C-j> <Esc><C-j>
    " tnoremap <C-h> <Esc><C-h>
    tnoremap <M-l> <C-\><C-n><C-W>l
    tnoremap <M-j> <C-\><C-n><C-W>j
    tnoremap <M-k> <C-\><C-n><C-W>k
    tnoremap <M-h> <C-\><C-n><C-W>h

    " help with quick insert or copy 
    " nnoremap <CR> i
    " nnoremap <space> <CR>
    vnoremap <CR> y
endif

" fix weird issue where n/N are reversed
nmap n /<CR>
nmap N ?<CR>
vmap n /<CR>
vmap N ?<CR>

lua << EOF
local iron = require("iron")

iron.core.set_config{
preferred = {
    python = "ipython"
},
repl_open_cmd = "rightbelow 20 split"
}
EOF
