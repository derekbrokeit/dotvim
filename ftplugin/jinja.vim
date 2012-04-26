" Jinja files

setlocal commentstring={#%s#}

let b:surround_{char2nr("e")} = "{% mark excerpt -%} \r {%- endmark %}"
let b:surround_{char2nr("h")} = "<!-- \r -->"
