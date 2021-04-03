set number
set tabstop=4
set expandtab
set shiftwidth=4
set whichwrap=b,s,[,],<,>
set title
set backspace=indent,eol,start
set smartindent
set history=100

set list listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:%

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

