" Quit when a (custom syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn  match ncComment ";.\+"
syn match ncGCodes "^G\d\+"
syn match ncMCodes "^M\d\+"

syntax match ncXAxis "\<[XYZ]-\?\d\+\>"
syntax match ncXAxis "\<[XYZ]-\?\.\d\+\>"
syntax match ncXAxis "\<[XYZ]-\?\d\+\."
syntax match ncXAxis "\<[XYZ]-\?\d\+\.\d\+\>"

syntax match ncEAxis "\<E-\?\d\+\>"
syntax match ncEAxis "\<E-\?\.\d\+\>"
syntax match ncEAxis "\<E-\?\d\+\."
syntax match ncEAxis "\<E-\?\d\+\.\d\+\>"

syntax match ncSAxis "\<[ABCS]-\?\d\+\>"
syntax match ncSAxis "\<[ABCS]-\?\.\d\+\>"
syntax match ncSAxis "\<[ABCS]-\?\d\+\."
syntax match ncSAxis "\<[ABCS]-\?\d\+\.\d\+\>"

syntax match ncPAxis "\<[IJKRP]-\?\d\+\>"
syntax match ncPAxis "\<[IJKRP]-\?\.\d\+\>"
syntax match ncPAxis "\<[IJKRP]-\?\d\+\."
syntax match ncPAxis "\<[IJKRP]-\?\d\+\.\d\+\>"

syntax match ncRapid "\<G\(0\+\)\>"

syntax match ncFeed "\<F-\?\d\+\>"
syntax match ncFeed "\<F-\?\.\d\+\>"
syntax match ncFeed "\<F-\?\d\+\."
syntax match ncFeed "\<F-\?\d\+\.\d\+\>"

syntax match ncTool "\<T\d\+\>"

hi def link ncComment Comment
hi def link ncGCodes MoreMsg
hi def link ncMCodes MoreMsg
hi def link ncXAxis WarningMsg
hi def link ncEAxis Keyword
hi def link ncSAxis VimString
hi def link ncPAxis VimString

hi def link ncRapid WarningMsg
hi def link ncIAxis Identifier
hi def link ncSpecials SpecialChar
hi def link ncFeed SpecialChar
hi def link ncTool Define

let b:current_syntax = "nc"
